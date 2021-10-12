import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_graphql_app/model/model.dart';
import 'package:graphql/client.dart';
import '../dining.dart';
part 'dining_state.dart';

class DiningCubit extends Cubit<DiningState> {
  final GraphQLClient _graphQLClient;
  final FetchPolicy _fetchPolicy;
  final CacheRereadPolicy _cacheRereadPolicy;
  final bool _carryForwardDataOnException;

  ObservableQuery? _observableQuery;

  DiningCubit({
    required GraphQLClient graphQLClient,
    required FetchPolicy fetchPolicy,
    required CacheRereadPolicy cacheRereadPolicy,
    required bool carryForwardDataOnException,
  })  : _graphQLClient = graphQLClient,
        _fetchPolicy = fetchPolicy,
        _cacheRereadPolicy = cacheRereadPolicy,
        _carryForwardDataOnException = carryForwardDataOnException,
        super(const DiningInitial());

  @override
  Future<void> close() {
    _observableQuery?.close();
    return super.close();
  }

  void loadRestaurants() async {
    emit(const DiningLoadInProgress());

    final options = WatchQueryOptions(
      document: gql(queryRestaurants),
      fetchResults: true,
      fetchPolicy: _fetchPolicy,
      cacheRereadPolicy: _cacheRereadPolicy,
      carryForwardDataOnException: _carryForwardDataOnException,
    );

    _observableQuery = _graphQLClient.watchQuery(options);

    _observableQuery?.stream.listen((QueryResult result) {
      if (result.isLoading) {
        emit(const DiningLoadInProgress());
        return;
      }
      if (result.hasException && result.data == null) {
        emit(DiningLoadFailure('${result.exception}'));
        return;
      }
      try {
        final restaurants = <Restaurant>[];
        for (var document in result.data?['restaurants'] ?? []) {
          restaurants.add(Restaurant.fromJson(document));
        }
        final source = _getSourceString(result.source);
        emit(DiningLoadSuccess(source, restaurants));
      } catch (e) {
        emit(DiningLoadFailure('$e'));
      }
    });
  }

  void refetch() => _observableQuery?.refetch();

  String _getSourceString(QueryResultSource? source) {
    if (source == QueryResultSource.cache) {
      return 'cache';
    } else if (source == QueryResultSource.network) {
      return 'network';
    } else if (source == QueryResultSource.loading) {
      return 'loading';
    } else if (source == QueryResultSource.optimisticResult) {
      return 'optimisticResult';
    } else {
      return '';
    }
  }
}
