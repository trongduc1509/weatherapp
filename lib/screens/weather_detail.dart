import 'package:flutter/material.dart';
import 'package:weather_app/constants/weather_decor.dart';
import 'package:weather_app/models/weather.dart';

class WeatherDetail extends StatelessWidget {
  final Weather weather;

  const WeatherDetail({Key? key, required this.weather}) : super(key: key);

  Widget currentWeather(Weather item) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(10.0),
      decoration: myWeatherDecor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(item.location,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
          Flexible(
            flex: 3,
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.horizontal,
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: SizedBox(
                    height: double.infinity,
                    child: Image.network(
                      'http:${item.iconCondition}',
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, exception, stacktrace) =>
                          Text(stacktrace.toString()),
                    ),
                  ),
                ),
                Flexible(
                  flex: 10,
                  child: Text(
                    '${item.tempC}°C',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              item.textCondition,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text('Local time: ${item.localTime}',
              style: const TextStyle(color: Colors.white, fontSize: 15)),
          const SizedBox(
            height: 10.0,
          ),
          Flexible(
            flex: 1,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Feels like ${item.feelsLikeC}°C',
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  'Wind ${item.windKph} km/h',
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  'UV ${item.uvIndex}',
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget forecastItem(WeatherForecast item) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(10.0),
      decoration: myWeatherDecor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            item.time.substring(11),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SizedBox(
              height: double.infinity * 0.5,
              width: 200,
              child: Image.network(
                'http:${item.iconCondition}',
                fit: BoxFit.fitHeight,
                errorBuilder: (context, exception, stacktrace) =>
                    Text(stacktrace.toString()),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${item.tempC}°C',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            item.textCondition,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (weather.iconCondition.contains('day'))
                  ? const AssetImage("assets/images/day.png")
                  : const AssetImage("assets/images/night.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 6,
                  child: currentWeather(weather),
                ),
                Flexible(
                  flex: 4,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weather.forecastList.length,
                    itemBuilder: (context, index) =>
                        forecastItem(weather.forecastList[index]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
