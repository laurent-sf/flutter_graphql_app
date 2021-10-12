import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';

class SelectOnExceptionBehavior extends StatelessWidget {
  const SelectOnExceptionBehavior({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CarryForwardDataOnException:',
              style: Theme.of(context).textTheme.headline6,
            ),
            ListTile(
              title: const Text('true'),
              leading: Radio<bool>(
                value: true,
                groupValue: state.carryForwardDataOnException,
                onChanged: (bool? value) =>
                    cubit.updateCarryForwardDataOnException(value!),
              ),
              subtitle: const Text(
                'If an exception occurred,  the result contains the data of the last event.',
              ),
            ),
            ListTile(
              title: const Text('false'),
              leading: Radio<bool>(
                value: false,
                groupValue: state.carryForwardDataOnException,
                onChanged: (bool? value) =>
                    cubit.updateCarryForwardDataOnException(value!),
              ),
              subtitle: const Text(
                'If an exception occurred, the data is null.',
              ),
            ),
          ],
        );
      },
    );
  }
}
