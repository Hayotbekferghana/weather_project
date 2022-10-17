import 'package:weather_project/data/local/local_db.dart';
import 'package:weather_project/data/models/cached_weather_info/cached_weather_item.dart';
import 'package:weather_project/data/services/notif_api_service/api_service.dart';

class NotificationRepository {
  NotificationRepository({required this.apiService});
  ApiService apiService;

  Future<bool> postNotification(
          {required String address,
          required String weatherType,
          required String temp}) =>
      apiService.postNotification(
          address: address, weatherType: weatherType, temp: temp);

  Future<List<CachedWeatherItem>> getAllWeathers() async =>
      LocalDatabase.getAllWeathers();
  Future<CachedWeatherItem> insertCachedWeather(
          CachedWeatherItem cachedWeatherItem) async =>
      LocalDatabase.insertCachedWeather(cachedWeatherItem);
  Future<int> deleteAllWeathers() async => LocalDatabase.deleteAllWeathers();
}
