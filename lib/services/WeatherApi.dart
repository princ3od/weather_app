import 'dart:convert';

import 'package:demo_login/models/Weather.dart';
import 'package:demo_login/utils/NetworkSp.dart';
import 'package:http/http.dart';
import 'WeatherFromApi.dart';

class WeatherApi {
  var client = Client();

  Future<Weather> findWeatherByLocation(String location) async {
    Uri url = Uri.parse(
        "$BASE_URL/$WEATHER?$QUERY_PARAM=$location&$APP_ID_PARAM=$APP_ID");
    var response;
    try {
      response = await client.get(url);
    } on Exception {
      print("client exception");
      return null;
    }
    if (response.statusCode == 200) {
      WeatherFromApi weatherFromApi;
      try {
        weatherFromApi = WeatherFromApi.fromJson(json.decode(response.body));
      } on FormatException {
        print("json format exception");
      }
      return weatherFromApi.toWeather();
    } else {
      print("request error: ${response.body}");
      return null;
    }
  }
}
