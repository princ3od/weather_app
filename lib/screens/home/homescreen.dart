import 'package:demo_login/screens/home/widgets/favoriteWeatherWidgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stacked/stacked.dart';
import 'homeViewModel.dart';
import 'widgets/historyWidget.dart';
import 'widgets/searchWidget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text("Error!")));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ViewModelBuilder<HomeViewModel>.nonReactive(
              viewModelBuilder: () => HomeViewModel(),
              onModelReady: ((viewModel) => viewModel.initilise()),
              builder: (context, viewModel, _) => Scaffold(
                    appBar: AppBar(
                      title: Text("Weather"),
                      actions: <Widget>[
                        searchWidget(context),
                        historyWidget(),
                      ],
                    ),
                    body: ListFavoriteWeatherWidget(),
                  ),
              disposeViewModel: false,
              // Tell the ViewModelBuilder to only fire the initialse function once
              initialiseSpecialViewModelsOnce: true);
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(body: Center(child: Text("Loading!")));
      },
    );
  }
}
