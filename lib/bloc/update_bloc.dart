import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  late Timer _timer;
  UpdateBloc() : super(UpdateInitial()) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        add(UpdateRefreshEvent());
      });
    });
    on<UpdateEvent>((event, emit) {
      emit(UpdateRefresh(random: DateTime.now().millisecond));
    });
  }
  @override
  Future<void> close() {
    _timer?.cancel(); // Cancel the timer
    return super.close();
  }
}
