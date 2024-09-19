import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'overview_event.dart';
part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref("/Sensors/Battery");

  OverviewBloc() : super(OverviewBatteryStatus(battery: 0)) {
    _databaseReference.onValue.listen((event) {
      final data = event.snapshot.value;
      data as int; // Get the new data
      add(OverviewEventDataChanged(
          battery: data)); // Add a new event to the bloc
    });

    on<OverviewEvent>((event, emit) {
      // TODO: implement event handler
      switch (event.runtimeType) {
        case OverviewEventDataChanged:
          emit(OverviewBatteryStatus(
              battery: (event as OverviewEventDataChanged).battery));
          break;
        default:
          break;
      }
    });
  }
}
