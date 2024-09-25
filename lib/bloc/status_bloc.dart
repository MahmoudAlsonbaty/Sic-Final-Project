import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final DatabaseReference _databaseSensorReference =
      FirebaseDatabase.instance.ref("/Sensors");
  final DatabaseReference _databaseControlReference =
      FirebaseDatabase.instance.ref("/Control");

  StatusBloc() : super(StatusInitial()) {
    _databaseSensorReference.onValue.listen((event) async {
      final data = event.snapshot.value;
      data as Map; // Get the new data
      print(data);
      final response = await http.get(
        Uri.parse(
            'http://api.weatherapi.com/v1/current.json?q=Giza&key=b59ce0d8e1fc42f1917222559242109'),
      );
      Map<String, dynamic> weather;
      if (response.statusCode == 200) {
        weather = jsonDecode(response.body);
      } else {
        throw Exception('Failed to load weather data');
      }
      print(weather);
      add(StatusDataChanged(
        windSpeed: weather?["current"]['wind_kph'] as double?,
        headLights: (await _databaseControlReference.child("lights").get())
            .value as bool,
        temperature: data['Temp'] as int?,
        mq: data['MQ'] as int?,
        rainData:
            ((await _databaseSensorReference.child("Rain").get()).value as int)
                .toDouble(),
        airQuality: data['Dust'] as double?,
        Humidity: data['Humidity'] as int?,
        uv: weather?["current"]['uv'] as double?,
      )); // Add a new event to the bloc
    }); // Add a new event to the bloc
    on<StatusEvent>((event, emit) {
      if (event is StatusDataChanged) {
        if (state is StatusInitial) {
          emit(StatusUpdate(
            windSpeed: event.windSpeed ?? 0,
            headLights: event.headLights ?? false,
            temperature: event.temperature ?? 0,
            mq: event.mq ?? 0,
            rainData: event.rainData ?? 0.0,
            airQuality: event.airQuality ?? 0,
            Humidity: event.Humidity ?? 0,
            uv: event.uv ?? 1,
          ));
        } else if (state is StatusUpdate) {
          emit(StatusUpdate(
            windSpeed: event.windSpeed ?? (state as StatusUpdate).windSpeed,
            headLights: event.headLights ?? (state as StatusUpdate).headLights,
            temperature:
                event.temperature ?? (state as StatusUpdate).temperature,
            mq: event.mq ?? (state as StatusUpdate).mq,
            rainData: event.rainData ?? (state as StatusUpdate).rainData,
            airQuality: event.airQuality ?? (state as StatusUpdate).airQuality,
            Humidity: event.Humidity ?? (state as StatusUpdate).Humidity,
            uv: event.uv ?? (state as StatusUpdate).uv,
          ));
        }
      } else if (event is StatusUpdateFirebaseEvent) {
        if (event.headLights != null) {
          _databaseControlReference.update({
            'lights': event.headLights,
          });
        }
      }
    });
  }
}
