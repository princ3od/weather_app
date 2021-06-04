import 'package:demo_login/models/Weather.dart';
import 'package:flutter/material.dart';

import 'PageIndicator.dart';

class WeatherScreen extends StatefulWidget {
  final int initialIndex;
  final List<Weather> weathers;

  WeatherScreen(this.initialIndex, this.weathers);

  @override
  State<StatefulWidget> createState() {
    return MState(initialIndex, weathers);
  }
}

class MState extends State with TickerProviderStateMixin {
  int initialIndex;
  List<Weather> weathers;

  MState(this.initialIndex, this.weathers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail",
          style: TextStyle(),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          pageViewWidget(),
          Container(
            margin: EdgeInsets.only(
              bottom: 44,
            ),
            child: PagerIndicator(
              itemCount: weathers.length,
              indicatorNormalColor: Colors.black26,
              indicatorSelectedColor: Colors.black87,
              indicatorPadding: 6,
              indicatorSize: 9,
              currentSelected: initialIndex,
            ),
          ),
        ],
      ),
    );
  }

  Widget pageViewWidget() {
    return PageView.builder(
      itemBuilder: (context, index) {
        return itemPageViewWidget(weathers[index]);
      },
      itemCount: weathers.length,
      controller: PageController(
        initialPage: initialIndex,
      ),
      onPageChanged: (currentPos) {
        setState(() {
          initialIndex = currentPos;
        });
      },
    );
  }

  Widget itemPageViewWidget(Weather weather) {
    return Hero(
      tag: "card ${weather.location}",
      child: Card(
        elevation: 3,
        margin: EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(36, 36, 0, 24),
              child: Text(
                "${weather.location}",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "${weather.main}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: leadingMainWidget(weather),
              subtitle: Text("${weather.des}"),
            ),
            detailWidget(
              AssetImage("assets/images/temp.png"),
              Text(
                "${weather.temp.toInt() / 10}°C",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            detailWidget(
              AssetImage("assets/images/pressure.png"),
              Text("${weather.pressure.toInt()} hPa"),
            ),
            detailWidget(
              AssetImage("assets/images/humidity.png"),
              Text("${weather.humidity.toInt()} %"),
            ),
          ],
        ),
      ),
    );
  }

  Widget leadingMainWidget(Weather weather) {
    if (weather.main == "Clouds") {
      return Container(
        height: 24,
        width: 24,
        child: Image(
          image: AssetImage(
            "assets/images/cloudy.png",
          ),
          color: Colors.black54,
        ),
      );
    } else if (weather.main == "Snow") {
      return Container(
        height: 24,
        width: 24,
        child: Image(
          image: AssetImage("assets/images/snowing.png"),
          color: Colors.black54,
        ),
      );
    } else {
      return Container(
        height: 24,
        width: 24,
        child: Image(
          image: AssetImage("assets/images/cloud.png"),
          color: Colors.black54,
        ),
      );
    }
  }

  Widget detailWidget(ImageProvider image, Widget title) {
    return ListTile(
      leading: Container(
        height: 24,
        width: 24,
        child: Image(
          image: image,
          color: Colors.black54,
        ),
      ),
      title: title,
    );
  }
}
