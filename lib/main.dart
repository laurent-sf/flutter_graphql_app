import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql_app/util/simple_bloc_observer.dart';
import 'package:graphql/client.dart';
import 'package:path_provider/path_provider.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();

  /// initialize Hive and wrap the default box in a HiveStore
  final appDocDirectory = await getApplicationDocumentsDirectory();
  final store = await HiveStore.open(path: '${appDocDirectory.path}/cache');

  const url = 'http://localhost:4000/';

  final graphQLClient = GraphQLClient(
    cache: GraphQLCache(store: store),
    link: HttpLink(url),
  );

  runApp(
    App(graphqlClient: graphQLClient),
  );
}
