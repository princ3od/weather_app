import 'package:demo_login/models/Weather.dart';
import 'package:demo_login/services/WeatherService.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchViewModel extends Model {
  static SearchViewModel _instance;

  static SearchViewModel getInstance() {
    if (_instance == null) {
      _instance = SearchViewModel();
    }
    return _instance;
  }

  Weather weatherSearched;
  bool isLoadingLocation = false;

  void getWeatherByLocation(String location) async {
    isLoadingLocation = true;
    notifyListeners();
    weatherSearched =
        await WeatherService.instance.getWeatherByLocation(location);
    isLoadingLocation = false;
    notifyListeners();
  }

  void favorite() async {
    weatherSearched.favorite = !weatherSearched.favorite;
    notifyListeners();
    await WeatherService.instance.saveWeather(weatherSearched);
  }

  static void destroyInstance() {
    _instance = null;
  }
}
