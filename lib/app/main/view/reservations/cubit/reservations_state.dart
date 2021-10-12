part of 'reservations_cubit.dart';

abstract class ReservationsState extends Equatable {
  const ReservationsState();
}

class ReservationsInitial extends ReservationsState {
  const ReservationsInitial();

  @override
  List<Object> get props => [];
}

class ReservationsLoadInProgress extends ReservationsState {
  const ReservationsLoadInProgress();

  @override
  List<Object> get props => [];
}

class ReservationsLoadSuccess extends ReservationsState {
  final List<Reservation> reservations;

  const ReservationsLoadSuccess(this.reservations);

  @override
  List<Object> get props => [reservations];
}

class ReservationsLoadFailure extends ReservationsState {
  final String error;

  const ReservationsLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
