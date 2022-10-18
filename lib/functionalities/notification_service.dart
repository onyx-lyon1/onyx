import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static int notificationId = 0;

  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    if (kDebugMode) {
      print("background tap notification");
    }
  }

  static final initializationSettings = InitializationSettings(
    android: const AndroidInitializationSettings('@mipmap/launcher_icon'),
    iOS: DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        // handle action
      },
    ),
    linux: LinuxInitializationSettings(
      defaultIcon: AssetsLinuxIcon('assets/icon.png'),
      defaultActionName: 'Notification',
    ),
  );

  static Future<void> init() async {
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // handle action
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static Future<void> showNotification(
      {required String title,
      required String body,
      required String payload}) async {
    notificationId++;
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'update',
          'update online',
          channelDescription: 'update online',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          ticker: "update on oloid",
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: payload,
    );
  }
}
