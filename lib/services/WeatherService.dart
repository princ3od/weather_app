import 'package:demo_login/models/Weather.dart';
import 'package:firebase_core/firebase_core.dart';

import 'WeatherApi.dart';
import 'WeatherDAL.dart';

class WeatherService {
  WeatherService._privateConstructor();
  static final WeatherService instance = WeatherService._privateConstructor();

  WeatherApi weatherApi = WeatherApi();
  WeatherDao weatherDao = WeatherDao();
  WeatherDAL weatherDAL = new WeatherDAL();

  Future<Weather> getWeatherByLocation(String location) async {
    Weather weather = await weatherApi.findWeatherByLocation(location);
    // Weather weatherLocal = await weatherDao.getWeatherByLocation(location);
    Weather weatherLocal = await weatherDAL.getWeatherByLocation(location);

    if (weatherLocal == null && weather != null) {
      await weatherDao.saveWeather(weather);
      await weatherDAL.saveWeather(weather);
      return weather;
    }

    if (weatherLocal == null && weather == null) {
      return null;
    }

    if (weatherLocal != null && weather == null) {
      return weatherLocal;
    }

    if (weatherLocal != null && weather != null) {
      weather.favorite = weatherLocal.favorite;
      await weatherDao.saveWeather(weather);
      await weatherDAL.saveWeather(weather);
      return weather;
    }

    return null;
  }

  Future<List<Weather>> getWeathers() {
    return weatherDAL.getWeathers();
  }

  Future<void> removeWeather(Weather weather) {
    return weatherDAL.removeWeather(weather);
  }

  Future<void> saveWeather(Weather weather) {
    return weatherDAL.saveWeather(weather);
  }

  Future<List<Weather>> getWeathersFavorite() {
    return weatherDAL.getWeathersFavorite();
  }

  void startListening() {
    weatherDAL.startListening();
  }
}
