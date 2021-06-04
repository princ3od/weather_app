import 'package:demo_login/models/Weather.dart';
import 'package:demo_login/screens/weather/WeatherScreen.dart';
import 'package:demo_login/widgets/WeatherItem.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scoped_model/scoped_model.dart';

import 'historyViewModel.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: HistoryViewModel.getInstance(),
      child: WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("History"),
          ),
          body: weathersWidget(),
        ),
        onWillPop: () {
          HistoryViewModel.destroyInstance();
          Navigator.pop(context, "pop from history");
        },
      ),
    );
  }

  Widget weathersWidget() {
    return ScopedModelDescendant<HistoryViewModel>(
      builder: (BuildContext context, Widget child, HistoryViewModel model) {
        return ListView.builder(
          itemCount: model.weathers.length,
          itemBuilder: (context, index) {
            return WeatherItem(
              onFavorite: (Weather weather) {
                model.updateFavorite(weather);
              },
              onClick: (Weather weather) {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.topToBottom,
                    child: WeatherScreen(
                      model.weathers.indexOf(weather),
                      model.weathers,
                    ),
                  ),
                );
              },
              weather: model.weathers[index],
              onDelete: (Weather weather) {
                model.deleteWeather(weather);
              },
              deleteAble: true,
            );
          },
        );
      },
    );
  }
}
