import 'package:data_sources/data_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/catalog/data/catalog_providers.dart';
import 'package:panelsolar/features/catalog/domain/cec_mappers.dart';

/// Búsqueda en el catálogo público CEC/SAM: importa solo los equipos que
/// elige el instalador. La primera vez descarga ≈ 6 MB.
class CecImportPage extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<CecImportPage> createState() => _CecImportPageState();
}

class _CecImportPageState extends ConsumerState<CecImportPage> {
  String _query = '';
  bool _inverters = false;
  final _imported = <String>{};

  Future<void> _import(Object item) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    switch (item) {
      case final CecModule m:
        await ref.read(panelModelRepositoryProvider).save(CecMappers.panel(m));
        setState(() => _imported.add(m.name));
      case final CecInverter i:
        await ref
            .read(inverterModelRepositoryProvider)
            .save(CecMappers.inverter(i));
        setState(() => _imported.add(i.name));
    }
    messenger.showSnackBar(SnackBar(content: Text(l10n.cecImported)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final catalog = ref.watch(cecCatalogProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.cecTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text(l10n.cecHelp),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              key: const Key('cec-search'),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: l10n.cecSearchHint,
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          SegmentedButton<bool>(
            segments: [
              ButtonSegment(value: false, label: Text(l10n.catalogPanels)),
              ButtonSegment(value: true, label: Text(l10n.catalogInverters)),
            ],
            selected: {_inverters},
            onSelectionChanged: (s) => setState(() => _inverters = s.first),
          ),
          Expanded(
            child: catalog.when(
              loading: () => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 12),
                    Text(l10n.cecLoading),
                  ],
                ),
              ),
              error: (_, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(l10n.cecError, textAlign: TextAlign.center),
                ),
              ),
              data: _results,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              CecCatalogClient.attribution,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _results(CecCatalog c) {
    final l10n = AppLocalizations.of(context);
    if (_query.trim().length < 2) {
      return Center(child: Text(l10n.cecTypeMore));
    }
    final items = _inverters
        ? CecParser.search(c.inverters, _query, (i) => i.name)
        : CecParser.search(c.modules, _query, (m) => m.name);
    if (items.isEmpty) return Center(child: Text(l10n.cecNoResults));
    return ListView(
      children: [
        for (final it in items)
          switch (it) {
            final CecModule m => _tile(
              m.name,
              l10n.catalogPanelSummary(
                m.pmaxW.round(),
                m.vocV.toStringAsFixed(1),
                m.iscA.toStringAsFixed(1),
              ),
              m,
            ),
            final CecInverter i => _tile(
              i.name,
              '${(i.pacW / 1000).toStringAsFixed(2)} kW · '
              '${i.mpptMinV.round()}–${i.mpptMaxV.round()} V',
              i,
            ),
            _ => const SizedBox.shrink(),
          },
      ],
    );
  }

  Widget _tile(String name, String subtitle, Object item) {
    final done = _imported.contains(name);
    return ListTile(
      key: Key('cec-item-$name'),
      title: Text(name),
      subtitle: Text(subtitle),
      trailing: IconButton(
        tooltip: AppLocalizations.of(context).cecImport,
        icon: Icon(done ? Icons.check_circle : Icons.download),
        onPressed: done ? null : () => _import(item),
      ),
    );
  }
}
