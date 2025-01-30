import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificaService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _notificationsPlugin.initialize(settings);

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));
  }

  static Future<void> showNotification(String consultaNome) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'consulta_channel', 
      'Consultas',
      channelDescription: 'Notificações para lembrete de consultas',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0, 
      'Lembrete de Consultas',
      'Esse é o seu lembrete da consulta de $consultaNome', 
      details,
    );
  }

  static Future<void> scheduleNotification(String consultaNome, DateTime consultaData) async {
    DateTime now = DateTime.now();
    DateTime scheduledDate = consultaData;

    tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    if (tzScheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      await showNotification(consultaNome);
      return;
    }

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'consulta_channel',
      'Consultas',
      channelDescription: 'Notificações para lembrete de consultas',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.zonedSchedule(
      0,
      'Lembrete de Consulta',
      'Esse é o seu lembrete da consulta de $consultaNome',
      tzScheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

   static Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      // Solicita a permissão
      await Permission.notification.request();
    }
  }
}