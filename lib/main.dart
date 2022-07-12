import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/constants/appbar.dart';
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
      appBar: const MyAppBar(),
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherNotFound) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'Invalid location!',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                )));
          }
        },
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherSearching) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WeatherFound) {
              return WeatherDetail(weather: state.getWeather);
            }
            return const SearchPage();
          },
        ),
      ),
    );
  }
}
