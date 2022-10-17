part of 'notification_cubit.dart';

abstract class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {}

class NotificationInProgress extends NotificationState {}

class NotificationInSuccess extends NotificationState {
  NotificationInSuccess({required this.weathers});
  List<CachedWeatherItem> weathers;
}

class NotificationInFailure extends NotificationState {
  NotificationInFailure({required this.errorText});
  String errorText;
}
