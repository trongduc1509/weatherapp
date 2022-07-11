import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:weather_app/models/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherRepo {
  Future<Weather> getWeatherDataFromApi(String city) async {
    final Response response = await get(Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=${dotenv.env['API_KEY']}&q=$city"));

    if (response.statusCode != 200) {
      throw Exception('Something went wrong!');
    }

    return Weather.fromJson(jsonDecode(response.body));
  }
}
