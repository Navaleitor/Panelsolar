import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/async_value_view.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/features/clients/presentation/client_providers.dart';
import 'package:panelsolar/features/clients/presentation/widgets/client_contact_card.dart';
import 'package:panelsolar/features/clients/presentation/widgets/client_projects_section.dart';
import 'package:panelsolar/features/utility_bills/presentation/bills_section.dart';

/// Ficha del cliente: contacto, proyectos y recibos de luz.
class ClientDetailPage extends ConsumerWidget {
  const new({required this.clientId, super.key});

  final String clientId;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.clientDeleteTitle,
      message: l10n.clientDeleteMessage,
    );
    if (!ok) return;
    await ref.read(clientRepositoryProvider).softDelete(clientId);
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final client = ref.watch(clientProvider(clientId));
    return Scaffold(
      appBar: AppBar(
        title: Text(client.value?.name ?? l10n.navClients),
        actions: [
          IconButton(
            tooltip: l10n.actionEdit,
            icon: const Icon(Icons.edit),
            onPressed: () => context.push(AppRoutes.clientEdit(clientId)),
          ),
          PopupMenuButton<void>(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => _delete(context, ref),
                child: Text(l10n.actionDelete),
              ),
            ],
          ),
        ],
      ),
      body: AsyncValueView(
        value: client,
        data: (c) {
          if (c == null || c.deletedAt != null) {
            return Center(child: Text(l10n.clientNotFound));
          }
          return ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              ClientContactCard(client: c),
              ClientProjectsSection(clientId: clientId),
              BillsSection(clientId: clientId),
            ],
          );
        },
      ),
    );
  }
}
