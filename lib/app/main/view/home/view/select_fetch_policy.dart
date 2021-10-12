import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';

import '../home.dart';

class SelectFetchPolicy extends StatelessWidget {
  const SelectFetchPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, next) {
        return previous.fetchPolicy != next.fetchPolicy;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FetchPolicy:',
              style: Theme.of(context).textTheme.headline6,
            ),
            ListTile(
              title: const Text('cacheAndNetwork'),
              leading: Radio<FetchPolicy>(
                value: FetchPolicy.cacheAndNetwork,
                groupValue: state.fetchPolicy,
                onChanged: (FetchPolicy? value) =>
                    cubit.updateFetchPolicy(value!),
              ),
              subtitle: const Text(
                'Return result from the cache first (if it exists), then return network result once it\'s available.',
              ),
            ),
            ListTile(
              title: const Text('cacheFirst'),
              leading: Radio<FetchPolicy>(
                value: FetchPolicy.cacheFirst,
                groupValue: state.fetchPolicy,
                onChanged: (FetchPolicy? value) =>
                    cubit.updateFetchPolicy(value!),
              ),
              subtitle: const Text(
                'Return result from the cache. Only fetch from the network if the cached result is not available.',
              ),
            ),
            ListTile(
              title: const Text('cacheOnly'),
              leading: Radio<FetchPolicy>(
                value: FetchPolicy.cacheOnly,
                groupValue: state.fetchPolicy,
                onChanged: (FetchPolicy? value) =>
                    cubit.updateFetchPolicy(value!),
              ),
              subtitle: const Text(
                'Return result from the cache if available, fail otherwise.',
              ),
            ),
            ListTile(
              title: const Text('networkOnly'),
              leading: Radio<FetchPolicy>(
                value: FetchPolicy.networkOnly,
                groupValue: state.fetchPolicy,
                onChanged: (FetchPolicy? value) =>
                    cubit.updateFetchPolicy(value!),
              ),
              subtitle: const Text(
                'Return result from the network, fail if network call doesn\'t succeed, save to cache.',
              ),
            ),
            ListTile(
              title: const Text('noCache'),
              leading: Radio<FetchPolicy>(
                value: FetchPolicy.noCache,
                groupValue: state.fetchPolicy,
                onChanged: (FetchPolicy? value) =>
                    cubit.updateFetchPolicy(value!),
              ),
              subtitle: const Text(
                'Return result from the network, fail if network call doesn\'t succeed, don\'t save to cache. ',
              ),
            ),
          ],
        );
      },
    );
  }
}
