import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/repo/weather_repo.dart';
import 'package:weather_app/screens/weather_detail.dart';
import './screens/search.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => WeatherBloc(WeatherRepo()),
            ),
          ],
          child: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherNotSearch) {
            return const SearchPage();
          }
          if (state is WeatherSearching) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WeatherFound) {
            return WeatherDetail(weather: state.getWeather);
          }
          return const SnackBar(
              content:
                  Text('Invalid location! Please enter a valid location!'));
        },
      ),
    );
  }
}
