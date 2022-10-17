import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_project/data/services/notif_api_service/api_client.dart';
import 'package:weather_project/utils/constants.dart';

class ApiService {
  ApiService({
    required this.apiClient,
  });
  ApiClient apiClient;

  Future<bool> postNotification(
      {required String address,
      required String weatherType,
      required String temp}) async {
    try {
      String baseUrl = apiClient.dio.options.baseUrl;
      Response response = await apiClient.dio.post(
        "$baseUrl$endPointUrl",
        options: Options(
          headers: {
            "Authorization": "key=$messageKey",
            "Content-type": contentType
          },
        ),
        data: {
          "to": "/topics/weathers",
          "notification": {"title": "Weather", "body": "New Weather"},
          "data": {
            "address": address,
            "weather_type": weatherType,
            "temp": temp,
            "route": "/sql"
          }
        },
      );
      if (response.data['success'] != 0) {
        print(response.data);
        debugPrint("SUCCESS = ${response.data['success']}");
        return true;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
