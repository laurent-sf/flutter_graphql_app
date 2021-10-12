import 'package:graphql/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'main/main.dart';

class App extends StatelessWidget {
  final GraphQLClient _graphqlClient;

  const App({
    Key? key,
    required GraphQLClient graphqlClient,
  })  : _graphqlClient = graphqlClient,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _graphqlClient),
      ],
      child: MaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MainPage(),
      ),
    );
  }
}
