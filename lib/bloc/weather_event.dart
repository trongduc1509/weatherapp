part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherFetch extends WeatherEvent {
  final String _city;

  const WeatherFetch(this._city);

  @override
  List<Object> get props => [_city];
}

class WeatherReset extends WeatherEvent {}
