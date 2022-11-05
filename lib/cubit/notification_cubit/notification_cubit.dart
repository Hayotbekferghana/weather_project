import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/data/local/local_db.dart';
import 'package:weather_project/data/models/cached_weather_info/cached_weather_item.dart';
import 'package:weather_project/data/repositories/notif_api_repository.dart';


part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({required this.notificationRepository})
      : super(NotificationInitial()) {
    getAllWeathers();
  }

  final NotificationRepository notificationRepository;

  void getAllWeathers() async {
    emit(NotificationInProgress());
    try {
      List<CachedWeatherItem> weathers =
          await notificationRepository.getAllWeathers();
      emit(NotificationInSuccess(weathers: weathers));
    } catch (error) {
      emit(NotificationInFailure(errorText: error.toString()));
    }
  }

  void deleteWeatherById(int id) async {
    try {
      await LocalDatabase.deleteWeatherById(id);
    } catch (e) {
      emit(NotificationInFailure(errorText: e.toString()));
    }
  }

  void postNotification(
      {required String address,
      required String weatherType,
      required String temp}) async {
    try {
      notificationRepository.postNotification(
        address: address,
        weatherType: weatherType,
        temp: temp,
      );
    } catch (e) {
      emit(NotificationInFailure(errorText: e.toString()));
    }
  }

  void insertCachedWeather(CachedWeatherItem cachedWeatherItem) async {
    await notificationRepository.insertCachedWeather(cachedWeatherItem);
    getAllWeathers();
  }

  void deleteAllWeathers() async {
    await notificationRepository.deleteAllWeathers();
    getAllWeathers();
  }
}
