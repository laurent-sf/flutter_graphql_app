import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_graphql_app/graphql/graphql.dart';
import 'package:flutter_graphql_app/model/model.dart';
import 'package:graphql/client.dart';

part 'reservations_state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  final GraphQLClient _graphQLClient;
  ObservableQuery? _observableQuery;

  ReservationsCubit({required GraphQLClient graphQLClient})
      : _graphQLClient = graphQLClient,
        super(const ReservationsLoadInProgress());

  @override
  Future<void> close() {
    _observableQuery?.close();
    return super.close();
  }

  void loadReservations() async {
    emit(const ReservationsLoadInProgress());

    final options = WatchQueryOptions(
      document: gql(queryReservations),
      fetchResults: true,
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
      carryForwardDataOnException: true,
    );

    _observableQuery = _graphQLClient.watchQuery(options);

    _observableQuery?.stream.listen((QueryResult result) {
      if (result.isLoading) {
        emit(const ReservationsLoadInProgress());
        return;
      }
      if (result.hasException && result.data == null) {
        emit(ReservationsLoadFailure('${result.exception}'));
        return;
      }
      try {
        final reservations = <Reservation>[];
        for (var document in result.data?['reservations'] ?? []) {
          reservations.add(Reservation.fromJson(document));
        }
        emit(ReservationsLoadSuccess(reservations));
      } catch (e) {
        emit(ReservationsLoadFailure('$e'));
      }
    });
  }

  void refetch() => _observableQuery?.refetch();
}
