import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../main.dart';

part 'main_tab_state.dart';

class MainTabCubit extends Cubit<MainTabState> {
  MainTabCubit() : super(const MainTabHome());

  void updatePage(int index) async {
    if (index == HomePageView.index) {
      emit(const MainTabHome());
    } else if (index == ReservationsPageView.index) {
      emit(const MainTabReservations());
    }
  }
}
