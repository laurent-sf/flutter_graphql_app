part of 'main_tab_cubit.dart';

@immutable
abstract class MainTabState extends Equatable {
  final int index;

  const MainTabState({required this.index});

  @override
  List<Object> get props => [index];
}

class MainTabHome extends MainTabState {
  const MainTabHome() : super(index: HomePageView.index);
}

class MainTabReservations extends MainTabState {
  const MainTabReservations() : super(index: ReservationsPageView.index);
}
