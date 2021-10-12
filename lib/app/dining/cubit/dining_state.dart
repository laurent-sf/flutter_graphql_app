part of 'dining_cubit.dart';

abstract class DiningState extends Equatable {
  const DiningState();
}

class DiningInitial extends DiningState {
  const DiningInitial();

  @override
  List<Object> get props => [];
}

class DiningLoadInProgress extends DiningState {
  const DiningLoadInProgress();

  @override
  List<Object> get props => [];
}

class DiningLoadSuccess extends DiningState {
  final String source;
  final List<Restaurant> restaurants;

  const DiningLoadSuccess(this.source, this.restaurants);

  @override
  List<Object> get props => [source, restaurants];
}

class DiningLoadFailure extends DiningState {
  final String error;

  const DiningLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
