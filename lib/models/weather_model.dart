class WeatherModel {
  final String city;
  final double temperature;
  final String description;
  final double humidity;
  final double windSpeed;
  final double pressure;
  final String icon;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, String city) {
    return WeatherModel(
      city: city,
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'].toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}
