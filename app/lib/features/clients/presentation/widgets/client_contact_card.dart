import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:persistence/persistence.dart';

/// Tarjeta con los datos de contacto. Mantener presionado un dato lo copia.
class ClientContactCard extends StatelessWidget {
  const new({required this.client, super.key});

  final Client client;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rows = <(IconData, String)>[
      if (client.phone != null) (Icons.phone, client.phone!),
      if (client.email != null) (Icons.email, client.email!),
      if (client.address != null) (Icons.home, client.address!),
      if (client.notes != null) (Icons.notes, client.notes!),
    ];
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (rows.isEmpty)
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(l10n.clientNoContact),
            ),
          for (final (icon, text) in rows)
            ListTile(
              leading: Icon(icon),
              title: Text(text),
              onLongPress: () async {
                await Clipboard.setData(ClipboardData(text: text));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(l10n.copied)));
              },
            ),
        ],
      ),
    );
  }
}
