import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:panelsolar/features/maintenance/domain/reminder.dart';
import 'package:timezone/data/latest_10y.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Programa los recordatorios locales de mantenimiento. Interfaz para
/// poder usar uno falso en pruebas.
abstract interface class ReminderScheduler {
  /// Pide permiso de notificaciones (Android 13+). `true` si se concedió.
  Future<bool> requestPermission();

  /// Borra lo programado y programa [reminders].
  Future<void> replaceAll(List<Reminder> reminders);
}

/// [ReminderScheduler] con `flutter_local_notifications`. Usa alarmas
/// inexactas (no requiere el permiso de alarmas exactas): pueden llegar
/// unos minutos tarde, suficiente para una visita de mantenimiento.
class LocalNotificationScheduler implements ReminderScheduler {
  new([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _ready = false;

  static const _channel = AndroidNotificationDetails(
    'maintenance',
    'Mantenimiento',
    channelDescription: 'Recordatorios de visitas de mantenimiento',
  );

  Future<void> _init() async {
    if (_ready) return;
    tz_data.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } on Object {
      // Sin zona del teléfono: se queda en UTC.
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    _ready = true;
  }

  AndroidFlutterLocalNotificationsPlugin? get _android => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  @override
  Future<bool> requestPermission() async {
    await _init();
    return await _android?.requestNotificationsPermission() ?? true;
  }

  @override
  Future<void> replaceAll(List<Reminder> reminders) async {
    await _init();
    await _plugin.cancelAllPendingNotifications();
    for (final r in reminders) {
      await _plugin.zonedSchedule(
        id: r.id,
        scheduledDate: tz.TZDateTime.from(r.at, tz.local),
        notificationDetails: const NotificationDetails(android: _channel),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        title: r.title,
        body: r.body,
        payload: r.projectId,
      );
    }
  }
}
