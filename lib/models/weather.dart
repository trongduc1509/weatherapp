class Weather {
  final String location;
  final String localTime;
  final String iconCondition;
  final String textCondition;
  final double tempC;
  final double feelsLikeC;
  final double windKph;
  final int uvIndex;

  Weather(
      {required this.location,
      required this.localTime,
      required this.iconCondition,
      required this.textCondition,
      required this.tempC,
      required this.feelsLikeC,
      required this.windKph,
      required this.uvIndex});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
      location: json['location']['name'],
      localTime: json['location']['localtime'],
      iconCondition: json['current']['condition']['icon'],
      textCondition: json['current']['condition']['text'],
      tempC: json['current']['temp_c'],
      feelsLikeC: json['current']['feelslike_c'],
      windKph: json['current']['wind_kph'],
      uvIndex: json['current']['uv']);
}
