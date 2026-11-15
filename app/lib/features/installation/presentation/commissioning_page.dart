import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/formatting/decimal_parser.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/optional_date_tile.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/installation/domain/commissioning_evaluation.dart';
import 'package:panelsolar/features/installation/presentation/installation_labels.dart';
import 'package:panelsolar/features/installation/presentation/installation_providers.dart';
import 'package:panelsolar/features/installation/presentation/widgets/string_tests_section.dart';
import 'package:panelsolar/features/installation/presentation/widgets/tri_state_check_tile.dart';
import 'package:panelsolar/features/photos/presentation/linked_photos_section.dart';
import 'package:persistence/persistence.dart';

/// Checklist de puesta en marcha (IEC 62446-1): strings, polaridad,
/// aislamiento, tierra, etiquetado, estado y fotos de evidencia.
class CommissioningPage extends ConsumerStatefulWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  @override
  ConsumerState<CommissioningPage> createState() => _CommissioningPageState();
}

class _CommissioningPageState extends ConsumerState<CommissioningPage> {
  final _technician = TextEditingController();
  final _insulation = TextEditingController();
  final _testVoltage = TextEditingController();
  final _groundingOhm = TextEditingController();
  final _notes = TextEditingController();
  CommissioningStatus _status = CommissioningStatus.pending;
  DateTime? _testedAt;
  bool? _polarity;
  bool? _grounding;
  bool? _labeling;
  bool _loading = true;

  /// Llena el formulario con lo guardado (una sola vez, al llegar el dato).
  void _fill(CommissioningRecord? r) {
    _loading = false;
    if (r == null) {
      _testedAt = DateTime.now().toUtc();
      return;
    }
    _status = r.status;
    _testedAt = r.testedAt;
    _technician.text = r.technician ?? '';
    _polarity = r.polarityOk;
    _insulation.text = decimalText(r.insulationMohm);
    _testVoltage.text = decimalText(r.insulationTestVoltageV);
    _grounding = r.groundingOk;
    _groundingOhm.text = decimalText(r.groundingOhm);
    _labeling = r.labelingOk;
    _notes.text = r.notes ?? '';
  }

  @override
  void dispose() {
    for (final c in [
      _technician,
      _insulation,
      _testVoltage,
      _groundingOhm,
      _notes,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  CommissioningInput get _input => (
    status: _status,
    testedAt: _testedAt,
    technician: _technician.text,
    polarityOk: _polarity,
    insulationMohm: parseDecimal(_insulation.text),
    insulationTestVoltageV: parseDecimal(_testVoltage.text),
    groundingOk: _grounding,
    groundingOhm: parseDecimal(_groundingOhm.text),
    labelingOk: _labeling,
    notes: _notes.text,
  );

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await ref
        .read(commissioningRepositoryProvider)
        .saveRecord(widget.projectId, _input);
    messenger.showSnackBar(SnackBar(content: Text(l10n.savedMessage)));
  }

  Widget _number(Key key, TextEditingController c, String label) => Padding(
    padding: const EdgeInsets.only(top: 12),
    child: TextField(
      key: key,
      controller: c,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final recordValue = ref.watch(commissioningProvider(widget.projectId));
    if (_loading && recordValue.hasValue) _fill(recordValue.value);
    final record = recordValue.value;
    final strings =
        ref.watch(stringTestsProvider(widget.projectId)).value ?? const [];
    final suggested = suggestStatus(record, strings);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.commissioningTitle)),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('commissioning-save'),
        onPressed: _loading ? null : _save,
        icon: const Icon(Icons.check),
        label: Text(l10n.actionSave),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                StringTestsSection(projectId: widget.projectId),
                SectionHeader(title: l10n.commissioningChecks),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OptionalDateTile(
                        label: l10n.commissioningDate,
                        value: _testedAt,
                        onChanged: (d) => setState(() => _testedAt = d),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _technician,
                        decoration: InputDecoration(
                          labelText: l10n.fieldTechnician,
                        ),
                      ),
                      TriStateCheckTile(
                        key: const Key('check-polarity'),
                        label: l10n.checkPolarityAll,
                        value: _polarity,
                        onChanged: (v) => setState(() => _polarity = v),
                      ),
                      _number(
                        const Key('insulation-mohm'),
                        _insulation,
                        l10n.insulationMohm,
                      ),
                      _number(
                        const Key('insulation-voltage'),
                        _testVoltage,
                        l10n.insulationTestVoltage,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          l10n.insulationHint,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      TriStateCheckTile(
                        key: const Key('check-grounding'),
                        label: l10n.checkGrounding,
                        value: _grounding,
                        onChanged: (v) => setState(() => _grounding = v),
                      ),
                      _number(
                        const Key('grounding-ohm'),
                        _groundingOhm,
                        l10n.groundingOhm,
                      ),
                      TriStateCheckTile(
                        key: const Key('check-labeling'),
                        label: l10n.checkLabeling,
                        value: _labeling,
                        onChanged: (v) => setState(() => _labeling = v),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _notes,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: l10n.commissioningNotes,
                        ),
                      ),
                    ],
                  ),
                ),
                SectionHeader(title: l10n.commissioningResult),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SegmentedButton<CommissioningStatus>(
                        key: const Key('commissioning-status'),
                        segments: [
                          for (final s in CommissioningStatus.values)
                            ButtonSegment(
                              value: s,
                              label: Text(commissioningStatusLabel(l10n, s)),
                            ),
                        ],
                        selected: {_status},
                        onSelectionChanged: (s) =>
                            setState(() => _status = s.first),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.commissioningSuggested(
                          commissioningStatusLabel(l10n, suggested),
                        ),
                        key: const Key('commissioning-suggested'),
                      ),
                    ],
                  ),
                ),
                if (record == null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(l10n.commissioningSaveForPhotos),
                  )
                else
                  LinkedPhotosSection(
                    projectId: widget.projectId,
                    recordId: record.id,
                    stage: PhotoStage.installation,
                    title: l10n.evidencePhotos,
                  ),
              ],
            ),
    );
  }
}
