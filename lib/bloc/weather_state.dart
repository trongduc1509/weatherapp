part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherNotSearch extends WeatherState {}

class WeatherSearching extends WeatherState {}

class WeatherFound extends WeatherState {
  final Weather _weather;

  const WeatherFound(this._weather);

  Weather get getWeather => _weather;

  @override
  List<Object> get props => [_weather];
}

class WeatherNotFound extends WeatherState {}
