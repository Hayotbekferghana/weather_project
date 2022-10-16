import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final LocalNotificationService localNotificationService = LocalNotificationService._();

  factory LocalNotificationService() {
    return localNotificationService;
  }

  LocalNotificationService._();

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void init() async {
    var myToken = await FirebaseMessaging.instance.getToken();
    debugPrint("GET TOKEN: $myToken");

    // Android
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");

    //IOS
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    //Set
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    tz.initializeTimeZones();
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    // handle action
  }

  // Android
  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  //IOS

  void onDidReceiveLocalNotification(
      int id,
      String? title,
      String? body,
      String? payload,
      ) async {
    print(payload);
  }

  //channel
  AndroidNotificationChannel androidNotificationChannel =
  const AndroidNotificationChannel(
    "my_channel",
    "Notification Lesson",
    importance: Importance.max,
    description: "My Notification description",
  );

  void showNotification(RemoteMessage remoteMessage) {
    debugPrint("SHOW NOTIFICATION");
    flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      remoteMessage.notification!.title,
      remoteMessage.notification!.body,

      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          priority: Priority.max,
          playSound: true,
          icon: "@mipmap/ic_launcher",
          channelShowBadge: true,
          showProgress: true,
          largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        ),
      ),
      payload: remoteMessage.data.toString(),
    );
  }

  void scheduleNotification(int seconds) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      12,
      "scheduleNotification",
      "EXAMPLE",
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: 'To remind you about upcoming birthdays',
        ),
      ),
      payload: "Notification DATA",
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void showPeriodically() async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1234,
      'repeating title',
      'repeating body',
      RepeatInterval.everyMinute,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: 'To remind you about upcoming birthdays',
        ),
      ),
      androidAllowWhileIdle: true,
      payload: "DATA",
    );
  }

  void showMyNotifInGivenTime(DateTime dt) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      "Notification",
      "EXAMPLE",
      tz.TZDateTime.from(dt, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: 'To remind you about upcoming birthdays',
        ),
      ),
      payload: "Notification DATA",
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void cancelAllNotifications() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  void cancelNotificationById(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}
