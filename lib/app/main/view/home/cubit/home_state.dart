part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  final FetchPolicy fetchPolicy;
  final CacheRereadPolicy cacheRereadPolicy;
  final bool carryForwardDataOnException;

  const HomeState({
    required this.fetchPolicy,
    required this.cacheRereadPolicy,
    required this.carryForwardDataOnException,
  });

  @override
  List<Object> get props => [
        fetchPolicy,
        cacheRereadPolicy,
        carryForwardDataOnException,
      ];
}

class HomeInitial extends HomeState {
  const HomeInitial({
    FetchPolicy fetchPolicy = FetchPolicy.cacheAndNetwork,
    CacheRereadPolicy cacheRereadPolicy = CacheRereadPolicy.mergeOptimistic,
    bool carryForwardDataOnException = true,
  }) : super(
          fetchPolicy: fetchPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          carryForwardDataOnException: carryForwardDataOnException,
        );
}
