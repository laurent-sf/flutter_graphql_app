import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_graphql_app/graphql/graphql.dart';
import 'package:graphql/client.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GraphQLClient _graphQLClient;
  HomeCubit({
    required GraphQLClient graphQLClient,
  })  : _graphQLClient = graphQLClient,
        super(const HomeInitial());

  void updateFetchPolicy(FetchPolicy fetchPolicy) {
    emit(HomeInitial(
      fetchPolicy: fetchPolicy,
      cacheRereadPolicy: state.cacheRereadPolicy,
      carryForwardDataOnException: state.carryForwardDataOnException,
    ));
  }

  void updateCacheRereadPolicy(CacheRereadPolicy cacheRereadPolicy) {
    emit(HomeInitial(
      fetchPolicy: state.fetchPolicy,
      cacheRereadPolicy: cacheRereadPolicy,
      carryForwardDataOnException: state.carryForwardDataOnException,
    ));
  }

  void updateCarryForwardDataOnException(bool carryForwardDataOnException) {
    emit(HomeInitial(
      fetchPolicy: state.fetchPolicy,
      cacheRereadPolicy: state.cacheRereadPolicy,
      carryForwardDataOnException: carryForwardDataOnException,
    ));
  }

  Future<String> updateRestaurantsVersion() async {
    try {
      final options = MutationOptions(
        document: gql(incrementRestaurantsVersion),
      );
      final result = await _graphQLClient.mutate(options);
      return result.hasException ? 'Failure' : 'Success';
    } catch (e) {
      return 'Failure';
    }
  }
}
