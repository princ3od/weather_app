import 'package:demo_login/screens/search/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stacked/stacked.dart';
import '../homeViewModel.dart';

Widget searchWidget(BuildContext context) => ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (BuildContext context, model, _) {
        return IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            var result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ),
            );
            if (result != null) {
              //update home view model
              model.updateWeatherFavorite();
            }
          },
        );
      },
    );
