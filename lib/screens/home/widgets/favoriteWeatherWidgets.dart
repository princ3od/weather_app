import 'package:demo_login/screens/weather/WeatherScreen.dart';
import 'package:demo_login/widgets/WeatherItem.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stacked/stacked.dart';
import '../homeViewModel.dart';

class ListFavoriteWeatherWidget extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return ListView.builder(
      itemCount: model.weatherFavorite.length,
      itemBuilder: (context, index) {
        return WeatherItem(
          weather: model.weatherFavorite[index],
          onClick: (weather) {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.topToBottom,
                child: WeatherScreen(
                  model.weatherFavorite.indexOf(weather),
                  model.weatherFavorite,
                ),
              ),
            );
          },
          onFavorite: (weather) {
            model.updateFavorite(weather);
          },
          onDelete: (weather) {
            model.deleteWeather(weather);
          },
          deleteAble: true,
        );
      },
    );
  }
}
