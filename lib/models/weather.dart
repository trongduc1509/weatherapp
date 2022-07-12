class Weather {
  final String location;
  final String localTime;
  final String iconCondition;
  final String textCondition;
  final double tempC;
  final double feelsLikeC;
  final double windKph;
  final double uvIndex;
  final List<WeatherForecast> forecastList;

  Weather(
      {required this.location,
      required this.localTime,
      required this.iconCondition,
      required this.textCondition,
      required this.tempC,
      required this.feelsLikeC,
      required this.windKph,
      required this.uvIndex,
      this.forecastList = const []});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final List<WeatherForecast> tempForecastList = [];
    for (int i = 0; i <= 22; i += 2) {
      tempForecastList.add(WeatherForecast(
          time: json['forecast']['forecastday'][0]['hour'][i]['time'],
          iconCondition: json['forecast']['forecastday'][0]['hour'][i]
              ['condition']['icon'],
          textCondition: json['forecast']['forecastday'][0]['hour'][i]
              ['condition']['text'],
          tempC: json['forecast']['forecastday'][0]['hour'][i]['temp_c']));
    }
    return Weather(
        location: json['location']['name'],
        localTime: json['location']['localtime'],
        iconCondition: json['current']['condition']['icon'],
        textCondition: json['current']['condition']['text'],
        tempC: json['current']['temp_c'],
        feelsLikeC: json['current']['feelslike_c'],
        windKph: json['current']['wind_kph'],
        uvIndex: json['current']['uv'],
        forecastList: tempForecastList);
  }
}

class WeatherForecast {
  final String time;
  final String iconCondition;
  final String textCondition;
  final double tempC;

  WeatherForecast(
      {required this.time,
      required this.iconCondition,
      required this.textCondition,
      required this.tempC});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      WeatherForecast(
          time: json['time'].substring(11),
          iconCondition: json['condition']['icon'],
          textCondition: json['condition']['text'],
          tempC: json['temp_c']);
}
