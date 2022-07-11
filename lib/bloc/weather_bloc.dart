import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather.dart';
import '../repo/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo _weatherRepo;

  WeatherBloc(this._weatherRepo) : super(WeatherNotSearch()) {
    on<WeatherFetch>((event, emit) async {
      emit(WeatherSearching());
      try {
        final weatherResult =
            await _weatherRepo.getWeatherDataFromApi(event._city);
        emit(WeatherFound(weatherResult));
      } catch (e) {
        emit(WeatherNotFound());
      }
    });

    on<WeatherReset>(((event, emit) => emit(WeatherNotSearch())));
  }
}
