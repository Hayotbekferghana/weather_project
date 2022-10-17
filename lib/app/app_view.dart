import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/cubit/notification_cubit/notification_cubit.dart';
import 'package:weather_project/data/repositories/notif_api_repository.dart';
import 'package:weather_project/data/services/notif_api_service/api_client.dart';
import 'package:weather_project/data/services/notif_api_service/api_service.dart';
import 'package:weather_project/presentations/router.dart';
import 'package:weather_project/utils/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:weather_project/data/models/cached_weather_info/cached_weather_item.dart';
import 'package:weather_project/data/services/local_notification_service.dart';

class App extends StatelessWidget {
  App({super.key});
  ApiService apiService = ApiService(apiClient: ApiClient());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NotificationRepository(apiService: apiService),
      child: BlocProvider(
        create: (context) => NotificationCubit(
          notificationRepository: context.read<NotificationRepository>(),
        ),
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // background
    FirebaseMessaging.onMessageOpenedApp.listen(backgroundHandleMessage);
    // terminated
    onTerminated();
    // foreground
    onForeground();
    super.initState();
  }

  Future<void> onForeground() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint("Foreground: ${message.notification!.title}");
        saveNotificationAndShowLocal(message);
        Navigator.pushNamed(context, message.data['route']);
      },
    );
  }

  Future<void> onTerminated() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((remoteMessage) async {
      if (remoteMessage != null) {
        debugPrint("O TERMINATED: ${remoteMessage.notification!.title}");
        saveNotificationAndShowLocal(remoteMessage);
        // Navigator.pushNamed(context, v.data["route"]);
      }
    });
  }

  Future<void> backgroundHandleMessage(RemoteMessage message) async {
    saveNotification(message);
    Navigator.pushNamed(context, message.data["route"]);
    debugPrint("ON MESSAGE OPENED APP: ${message.notification!.title}");
  }

  void saveNotificationAndShowLocal(RemoteMessage message) {
    LocalNotificationService.localNotificationService.showNotification(message);
    var data = message.data;
    CachedWeatherItem cachedWeatherItem = CachedWeatherItem(
      addressName: data["address"],
      weatherType: data["weather_type"],
      temperature: data["temp"],
    );
    BlocProvider.of<NotificationCubit>(context)
        .insertCachedWeather(cachedWeatherItem);
  }

  void saveNotification(RemoteMessage message) {
    var data = message.data;
    CachedWeatherItem cachedWeatherItem = CachedWeatherItem(
      addressName: data["address"],
      weatherType: data["weather_type"],
      temperature: data["temp"],
    );
    BlocProvider.of<NotificationCubit>(context)
        .insertCachedWeather(cachedWeatherItem);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: tabRoute,
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}
