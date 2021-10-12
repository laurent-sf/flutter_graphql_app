import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';

import '../home.dart';

class SelectCachePolicy extends StatelessWidget {
  const SelectCachePolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, next) {
        return previous.cacheRereadPolicy != next.cacheRereadPolicy;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CacheRereadPolicy:',
              style: Theme.of(context).textTheme.headline6,
            ),
            ListTile(
              title: const Text('mergeOptimistic'),
              leading: Radio<CacheRereadPolicy>(
                value: CacheRereadPolicy.mergeOptimistic,
                groupValue: state.cacheRereadPolicy,
                onChanged: (CacheRereadPolicy? value) =>
                    cubit.updateCacheRereadPolicy(value!),
              ),
              subtitle: const Text(
                'Merge relevant optimistic data from the cache before returning.',
              ),
            ),
            ListTile(
              title: const Text('ignoreOptimisitic'),
              leading: Radio<CacheRereadPolicy>(
                value: CacheRereadPolicy.ignoreOptimisitic,
                groupValue: state.cacheRereadPolicy,
                onChanged: (CacheRereadPolicy? value) =>
                    cubit.updateCacheRereadPolicy(value!),
              ),
              subtitle: const Text(
                'Ignore optimistic data, but still allow for non-optimistic cache rebroadcast if applicable.',
              ),
            ),
            ListTile(
              title: const Text('ignoreAll'),
              leading: Radio<CacheRereadPolicy>(
                value: CacheRereadPolicy.ignoreAll,
                groupValue: state.cacheRereadPolicy,
                onChanged: (CacheRereadPolicy? value) =>
                    cubit.updateCacheRereadPolicy(value!),
              ),
              subtitle: const Text(
                ' Ignore all cache data besides the result, and never rebroadcast the result, even if the underlying cache data changes',
              ),
            ),
          ],
        );
      },
    );
  }
}
