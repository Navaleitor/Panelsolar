import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/async_value_view.dart';
import 'package:panelsolar/core/widgets/empty_state.dart';
import 'package:panelsolar/features/clients/presentation/client_providers.dart';

/// Lista de clientes con búsqueda. Botón "+" para dar de alta.
class ClientsPage extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends ConsumerState<ClientsPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final clients = ref.watch(clientListProvider(_query));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navClients)),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'clients-fab',
        onPressed: () => context.push(AppRoutes.clientNew),
        icon: const Icon(Icons.person_add),
        label: Text(l10n.clientNew),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              key: const Key('clients-search'),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: l10n.clientsSearchHint,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          Expanded(
            child: AsyncValueView(
              value: clients,
              data: (list) {
                if (list.isEmpty) {
                  return EmptyState(
                    icon: Icons.people_outline,
                    message: _query.trim().isEmpty
                        ? l10n.clientsEmpty
                        : l10n.clientsNoMatches,
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 96),
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final client = list[index];
                    final subtitle = [
                      client.phone,
                      client.email,
                    ].whereType<String>().join(' · ');
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(client.name.characters.first.toUpperCase()),
                      ),
                      title: Text(client.name),
                      subtitle: subtitle.isEmpty ? null : Text(subtitle),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () =>
                          context.push(AppRoutes.clientDetail(client.id)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
