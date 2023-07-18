import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'nav_bar_event.dart';
part 'nav_bar_state.dart';

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageState> {
  LandingPageBloc() : super(const LandingPageInitial(tabIndex: 1)) {
    on<LandingPageEvent>((event, emit) {
      if (event is TabChange) {
        //print(event.tabIndex);
        emit(LandingPageInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
