import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_graphql_app/graphql/graphql.dart';
import 'package:graphql/client.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final GraphQLClient _graphQLClient;

  RestaurantCubit({
    required GraphQLClient graphQLClient,
  })  : _graphQLClient = graphQLClient,
        super(RestaurantInitial());

  Future<String> reserve(String id) async {
    final options = MutationOptions(
      document: gql(createReservation),
      variables: {'restaurantId': id},
      update: (GraphQLDataProxy cache, QueryResult? result) {
        if (result?.data != null) {
          final request = Request(
            operation: Operation(document: gql(queryReservations)),
          );
          cache.writeQuery(request, data: result!.data!);
        }
      },
    );
    final result = await _graphQLClient.mutate(options);
    return result.hasException ? 'Failure' : 'Success';
  }

  Future<String> updateAndFetchRestaurants() async {
    final options = MutationOptions(
      document: gql(incrementRestaurantsVersion),
    );
    final result = await _graphQLClient.mutate(options);
    if (result.hasException) {
      return 'Failure';
    } else {
      final queryOptions = QueryOptions(
        document: gql(queryRestaurants),
        fetchPolicy: FetchPolicy.networkOnly,
      );
      await _graphQLClient.query(queryOptions);
      return 'Success';
    }
  }
}
