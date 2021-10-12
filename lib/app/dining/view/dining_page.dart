import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql_app/app/restaurant/restaurant.dart';
import 'package:flutter_graphql_app/component/component.dart';
import 'package:flutter_graphql_app/model/model.dart';
import 'package:flutter_graphql_app/util/custom_route.dart';
import 'package:graphql/client.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../dining.dart';

class DiningPage extends StatefulWidget {
  const DiningPage({Key? key}) : super(key: key);

  static Future<dynamic> open(
    BuildContext context,
    FetchPolicy fetchPolicy,
    CacheRereadPolicy cacheRereadPolicy,
    bool carryForwardDataOnException,
  ) async {
    return Navigator.push(
      context,
      noAnimation(
        BlocProvider(
          create: (context) => DiningCubit(
            graphQLClient: context.read<GraphQLClient>(),
            fetchPolicy: fetchPolicy,
            cacheRereadPolicy: cacheRereadPolicy,
            carryForwardDataOnException: carryForwardDataOnException,
          )..loadRestaurants(),
          child: const DiningPage(),
        ),
      ),
    );
  }

  @override
  _DiningPageState createState() => _DiningPageState();
}

class _DiningPageState extends State<DiningPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiningCubit, DiningState>(
      builder: (context, state) {
        final source = state is DiningLoadSuccess ? state.source : '';
        return CustomPage(
          title: '${AppLocalizations.of(context)!.dining} - $source',
          bottom: const CustomLocation(),
          child: Builder(
            builder: (_) {
              if (state is DiningLoadInProgress) {
                return const _DiningLoading();
              } else if (state is DiningLoadSuccess) {
                return _DiningLoadSuccess(
                  restaurants: state.restaurants,
                );
              } else if (state is DiningLoadFailure) {
                return SliverFillRemaining(
                  child: CustomError(
                    error: state.error,
                    retry: () => context.read<DiningCubit>().refetch(),
                  ),
                );
              } else {
                return const SliverFillRemaining();
              }
            },
          ),
        );
      },
    );
  }
}

class _DiningLoading extends StatelessWidget {
  const _DiningLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - kToolbarHeight * 2),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ShimmerCard(),
            ShimmerCard(),
            ShimmerCard(),
            ShimmerCard(),
            ShimmerCard(),
            ShimmerCard(),
          ],
        ),
      ),
    ));
  }
}

class _DiningLoadSuccess extends StatelessWidget {
  final List<Restaurant> restaurants;

  const _DiningLoadSuccess({Key? key, required this.restaurants})
      : super(key: key);

  void openRestaurant(BuildContext context, Restaurant restaurant) {
    RestaurantPage.open(context, restaurant);
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) {
          final restaurant = restaurants[i];
          return Column(
            children: [
              DiningCard(
                title: '${restaurant.name} - ${restaurant.version}',
                subtitle: '${restaurant.description}\n${restaurant.hours}',
                src: restaurant.photo,
                onTap: () => openRestaurant(context, restaurant),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              )
            ],
          );
        },
        childCount: restaurants.length,
      ),
    );
  }
}
