import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql_app/app/dining/dining.dart';
import 'package:graphql/client.dart';

import '../home.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  static const index = 0;

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  void openDiningPage(BuildContext context) {
    final state = context.read<HomeCubit>().state;

    DiningPage.open(
      context,
      state.fetchPolicy,
      state.cacheRereadPolicy,
      state.carryForwardDataOnException,
    );
  }

  void clearCache(BuildContext context) async {
    context.read<GraphQLClient>().cache.store.reset();
    const snackBar = SnackBar(
      content: Text('Success'),
      duration: Duration(milliseconds: 300),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void updateVersions(BuildContext context) async {
    final msg = await context.read<HomeCubit>().updateRestaurantsVersion();
    final snackBar = SnackBar(
      content: Text(msg),
      duration: const Duration(milliseconds: 300),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => HomeCubit(
        graphQLClient: context.read<GraphQLClient>(),
      ),
      child: Builder(
        builder: (context) => SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: const [
                              SelectFetchPolicy(),
                              SelectCachePolicy(),
                              SelectOnExceptionBehavior(),
                              SizedBox(height: 50)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                          ),
                          onPressed: () => clearCache(context),
                          child: const Text(
                            'Clear\nCache',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => openDiningPage(context),
                          child: const Text(
                            'Open Dining',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent,
                          ),
                          onPressed: () => updateVersions(context),
                          child: const Text(
                            'Update Versions',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
