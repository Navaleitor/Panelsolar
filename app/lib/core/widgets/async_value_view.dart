import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Muestra un `AsyncValue`: indicador mientras carga, mensaje si falla y
/// [data] cuando hay valor.
class AsyncValueView<T> extends StatelessWidget {
  const new({required this.value, required this.data, super.key});

  final AsyncValue<T> value;
  final Widget Function(T value) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            AppLocalizations.of(context).errorGeneric,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
