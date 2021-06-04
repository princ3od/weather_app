import 'package:demo_login/screens/history/historyscreen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stacked/stacked.dart';

import '../homeViewModel.dart';

Widget historyWidget() {
  return ViewModelBuilder<HomeViewModel>.reactive(
    viewModelBuilder: () => HomeViewModel(),
    builder: (context, viewModel, _) {
      return IconButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HistoryScreen();
              },
            ),
          );
          if (result != null) {
            viewModel.updateWeatherFavorite();
          }
        },
        icon: Icon(Icons.history),
      );
    },
  );
}
