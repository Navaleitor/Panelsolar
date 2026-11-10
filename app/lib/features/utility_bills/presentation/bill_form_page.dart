import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/core/widgets/date_field_tile.dart';
import 'package:panelsolar/features/utility_bills/domain/billing_period_math.dart';
import 'package:panelsolar/features/utility_bills/domain/money_parser.dart';
import 'package:panelsolar/features/utility_bills/presentation/billing_period_label.dart';
import 'package:persistence/persistence.dart';
import 'package:regional_packs/regional_packs.dart';

/// Alta ([billId] nulo) o edición de un recibo de luz del cliente.
class BillFormPage extends ConsumerStatefulWidget {
  const new({required this.clientId, this.billId, super.key});

  final String clientId;
  final String? billId;

  @override
  ConsumerState<BillFormPage> createState() => _BillFormPageState();
}

class _BillFormPageState extends ConsumerState<BillFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _kwh = TextEditingController();
  final _amount = TextEditingController();
  String? _tariffCode;
  BillingPeriod _period = BillingPeriod.bimonthly;
  late DateTime _start;
  late DateTime _end;
  bool _loading = true;
  bool _saving = false;

  bool get _isEdit => widget.billId != null;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _start = DateTime.utc(now.year, now.month - 2, now.day);
    _end = BillingPeriodMath.defaultEnd(_start, _period);
    unawaited(_load());
  }

  /// En edición carga el recibo; en alta sugiere fechas y tarifa a partir
  /// del último recibo del cliente.
  Future<void> _load() async {
    final repo = ref.read(utilityBillRepositoryProvider);
    if (_isEdit) {
      final b = await repo.findById(widget.billId!);
      if (b != null) {
        _start = b.periodStart;
        _end = b.periodEnd;
        _period = b.billingPeriod;
        _tariffCode = b.tariffCode;
        _kwh.text = b.energyKwh == b.energyKwh.roundToDouble()
            ? b.energyKwh.toStringAsFixed(0)
            : b.energyKwh.toString();
        _amount.text = b.amountCents == null
            ? ''
            : (b.amountCents! / 100).toStringAsFixed(2);
      }
    } else {
      final bills = await repo.listByClient(widget.clientId);
      if (bills.isNotEmpty) {
        final last = bills.last;
        _period = last.billingPeriod;
        _tariffCode = last.tariffCode;
        _start = BillingPeriodMath.nextStart(last.periodEnd);
        _end = BillingPeriodMath.defaultEnd(_start, _period);
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _kwh.dispose();
    _amount.dispose();
    super.dispose();
  }

  void _onTariff(String? code) {
    setState(() {
      _tariffCode = code;
      final tariff = mexicoTariffs.byCode(code);
      if (tariff != null && !_isEdit) {
        _period = billingPeriodOf(tariff);
        _end = BillingPeriodMath.defaultEnd(_start, _period);
      }
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final repo = ref.read(utilityBillRepositoryProvider);
    final kwh = parseDecimal(_kwh.text)!;
    final cents = parseMoneyToCents(_amount.text);
    if (_isEdit) {
      await repo.update(
        widget.billId!,
        periodStart: _start,
        periodEnd: _end,
        billingPeriod: _period,
        energyKwh: kwh,
        amountCents: cents,
        tariffCode: _tariffCode,
      );
    } else {
      await repo.create(
        clientId: widget.clientId,
        periodStart: _start,
        periodEnd: _end,
        billingPeriod: _period,
        energyKwh: kwh,
        amountCents: cents,
        tariffCode: _tariffCode,
      );
    }
    if (mounted) context.pop();
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.billDeleteTitle,
      message: l10n.billDeleteMessage,
    );
    if (!ok) return;
    await ref.read(utilityBillRepositoryProvider).softDelete(widget.billId!);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? l10n.billEdit : l10n.billNew),
        actions: [
          if (_isEdit)
            IconButton(
              tooltip: l10n.actionDelete,
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String?>(
              key: const Key('bill-tariff'),
              initialValue: _tariffCode,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: l10n.fieldTariff,
                prefixIcon: const Icon(Icons.receipt_long),
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(child: Text(l10n.tariffNone)),
                for (final t in mexicoTariffs.tariffs)
                  DropdownMenuItem(value: t.code, child: Text(t.name(lang))),
              ],
              onChanged: _onTariff,
            ),
            const SizedBox(height: 16),
            SegmentedButton<BillingPeriod>(
              key: const Key('bill-period'),
              segments: [
                for (final p in BillingPeriod.values)
                  ButtonSegment(
                    value: p,
                    label: Text(billingPeriodLabel(l10n, p)),
                  ),
              ],
              selected: {_period},
              onSelectionChanged: (s) => setState(() {
                _period = s.first;
                _end = BillingPeriodMath.defaultEnd(_start, _period);
              }),
            ),
            const SizedBox(height: 16),
            DateFieldTile(
              key: const Key('bill-start'),
              label: l10n.fieldPeriodStart,
              value: _start,
              onChanged: (d) => setState(() {
                _start = d;
                _end = BillingPeriodMath.defaultEnd(d, _period);
              }),
            ),
            const SizedBox(height: 8),
            DateFieldTile(
              key: const Key('bill-end'),
              label: l10n.fieldPeriodEnd,
              value: _end,
              onChanged: (d) => setState(() => _end = d),
            ),
            if (_end.isBefore(_start))
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  l10n.validationPeriod,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('bill-kwh'),
              controller: _kwh,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.fieldEnergyKwh,
                suffixText: 'kWh',
                prefixIcon: const Icon(Icons.bolt),
                border: const OutlineInputBorder(),
              ),
              validator: (v) {
                final value = parseDecimal(v ?? '');
                return (value == null || value < 0)
                    ? l10n.validationNumber
                    : null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('bill-amount'),
              controller: _amount,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.fieldAmount,
                prefixText: r'$ ',
                suffixText: 'MXN',
                prefixIcon: const Icon(Icons.payments),
                border: const OutlineInputBorder(),
              ),
              validator: (v) {
                final text = v?.trim() ?? '';
                if (text.isEmpty) return null;
                final cents = parseMoneyToCents(text);
                return (cents == null || cents < 0)
                    ? l10n.validationNumber
                    : null;
              },
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              key: const Key('bill-save'),
              onPressed: (_saving || _end.isBefore(_start)) ? null : _save,
              icon: const Icon(Icons.save),
              label: Text(l10n.actionSave),
            ),
          ],
        ),
      ),
    );
  }
}
