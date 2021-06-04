import 'package:demo_login/models/Weather.dart';
import 'package:demo_login/services/WeatherService.dart';
import 'package:scoped_model/scoped_model.dart';

class HistoryViewModel extends Model {
  static HistoryViewModel _instance;

  static HistoryViewModel getInstance() {
    if (_instance == null) {
      _instance = HistoryViewModel();
    }
    return _instance;
  }

  List<Weather> weathers = [];

  HistoryViewModel() {
    updateWeather();
  }

  void updateWeather() async {
    weathers = await WeatherService.instance.getWeathers();
    notifyListeners();
  }

  void updateFavorite(Weather weather) async {
    weather.favorite = !weather.favorite;
    notifyListeners();
    await WeatherService.instance.saveWeather(weather);
  }

  void deleteWeather(Weather weather) async {
    await WeatherService.instance.removeWeather(weather);
  }

  static void destroyInstance() {
    _instance = null;
  }
}
