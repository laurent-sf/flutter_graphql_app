import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql_app/component/component.dart';
import 'package:flutter_graphql_app/model/model.dart';
import 'package:graphql/client.dart';

import '../reservations.dart';

class ReservationsPageView extends StatefulWidget {
  const ReservationsPageView({Key? key}) : super(key: key);

  static const index = 1;

  @override
  _ReservationsPageViewState createState() => _ReservationsPageViewState();
}

class _ReservationsPageViewState extends State<ReservationsPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => ReservationsCubit(
        graphQLClient: context.read<GraphQLClient>(),
      )..loadReservations(),
      child: BlocBuilder<ReservationsCubit, ReservationsState>(
          builder: (context, state) {
        if (state is ReservationsLoadInProgress) {
          return const _ReservationsLoading();
        } else if (state is ReservationsLoadSuccess) {
          return _ReservationsLoadSuccess(
            reservations: state.reservations,
          );
        } else if (state is ReservationsLoadFailure) {
          return CustomError(
            error: state.error,
            retry: () => context.read<ReservationsCubit>().refetch(),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}

class _ReservationsLoading extends StatelessWidget {
  const _ReservationsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ReservationsLoadSuccess extends StatelessWidget {
  final List<Reservation> reservations;
  const _ReservationsLoadSuccess({
    Key? key,
    required this.reservations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reservations.length,
      itemBuilder: (_, i) {
        final reservation = reservations[i];
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: reservation.restaurantPhoto,
                fit: BoxFit.fill,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  reservation.id,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        );
      },
    );
  }
}
