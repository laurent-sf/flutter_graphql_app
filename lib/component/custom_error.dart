import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomError extends StatelessWidget {
  /// Creates a widget that displays an error message with an icon and a button to retry.

  final String _error;
  final Function()? _retry;

  const CustomError({Key? key, required String error, Function()? retry})
      : _error = error,
        _retry = retry,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error,
              size: 64, color: Theme.of(context).colorScheme.error),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_error, textAlign: TextAlign.center),
          ),
          ElevatedButton(
            onPressed: _retry,
            child: Text(AppLocalizations.of(context)!.retry),
          ),
        ],
      ),
    );
  }
}
