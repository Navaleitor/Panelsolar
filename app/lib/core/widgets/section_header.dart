import 'package:flutter/material.dart';

/// Título de sección con acción opcional a la derecha.
class SectionHeader extends StatelessWidget {
  const new({required this.title, this.action, super.key});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          ?action,
        ],
      ),
    );
  }
}
