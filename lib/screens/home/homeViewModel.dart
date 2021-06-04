import 'package:demo_login/models/Weather.dart';
import 'package:demo_login/services/WeatherService.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  static HomeViewModel _instance;

  static HomeViewModel getInstance() {
    if (_instance == null) {
      _instance = HomeViewModel();
    }
    return _instance;
  }

  List<Weather> weatherFavorite = [];

  void initilise() async {
    WeatherService.instance.startListening();
    updateWeatherFavorite();
  }

  void updateWeatherFavorite() async {
    weatherFavorite = await WeatherService.instance.getWeathersFavorite();
    print("updated");
    notifyListeners();
  }

  void updateFavorite(Weather weather) async {
    weather.favorite = !weather.favorite;
    await WeatherService.instance.saveWeather(weather);
    updateWeatherFavorite();
  }

  void deleteWeather(Weather weather) async {
    await WeatherService.instance.removeWeather(weather);
    notifyListeners();
  }
}
