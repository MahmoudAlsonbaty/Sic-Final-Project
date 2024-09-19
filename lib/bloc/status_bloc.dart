import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

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
      add(StatusDataChanged(
        windSpeed: data?['windSpeed'] as int?,
        headLights: (await _databaseControlReference.child("lights").get())
            .value as bool,
        temperature: data['Temp'] as int?,
        batteryTemperature: data['Battery Temp'] as int?,
        fanSpeed:
            ((await _databaseControlReference.child("Fan").get()).value as int)
                .toDouble(),
        airQuality: data['airQuality'] as int?,
        Humidity: data['Humidity'] as int?,
        uv: data['uv'] as int?,
      )); // Add a new event to the bloc
    }); // Add a new event to the bloc
    on<StatusEvent>((event, emit) {
      if (event is StatusDataChanged) {
        if (state is StatusInitial) {
          emit(StatusUpdate(
            windSpeed: event.windSpeed ?? 0,
            headLights: event.headLights ?? false,
            temperature: event.temperature ?? 0,
            batteryTemperature: event.batteryTemperature ?? 0,
            fanSpeed: event.fanSpeed ?? 0.0,
            airQuality: event.airQuality ?? 0,
            Humidity: event.Humidity ?? 0,
            uv: event.uv ?? 0,
          ));
        } else if (state is StatusUpdate) {
          emit(StatusUpdate(
            windSpeed: event.windSpeed ?? (state as StatusUpdate).windSpeed,
            headLights: event.headLights ?? (state as StatusUpdate).headLights,
            temperature:
                event.temperature ?? (state as StatusUpdate).temperature,
            batteryTemperature: event.batteryTemperature ??
                (state as StatusUpdate).batteryTemperature,
            fanSpeed: event.fanSpeed ?? (state as StatusUpdate).fanSpeed,
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
        if (event.fanSpeed != null) {
          _databaseControlReference.update({
            'Fan': event.fanSpeed,
          });
        }
      }
    });
  }
}
