import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

import 'dart:math';

class WeatherService {
  static const String apiKey = '98d02d54d7464fe2070ce0c1cae9cb13';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const List<String> allCities = [
    'Paris',
    'London',
    'New York',
    'Tokyo',
    'Sydney',
    'Berlin',
    'Madrid',
    'Rome',
    'Istanbul',
    'Dubai',
    'Singapore',
    'Hong Kong',
    'Bangkok',
    'Mumbai',
    'Delhi',
    'Sao Paulo',
    'Mexico City',
    'Los Angeles',
    'Chicago',
    'Toronto',
    'Moscow',
    'Beijing',
    'Shanghai'
  ];

  static List<String> getRandomCities() {
    final random = Random();
    final cities = List<String>.from(allCities);
    cities.shuffle(random);
    return cities.take(5).toList();
  }

  Future<List<WeatherModel>> getWeatherForAllCities() async {
    List<WeatherModel> weatherList = [];
    final cities = getRandomCities();
    
    for (var city in cities) {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'),
        );

        if (response.statusCode == 200) {
          final weather = WeatherModel.fromJson(json.decode(response.body), city);
          weatherList.add(weather);
        } else {
          throw Exception('Failed to load weather data for $city');
        }
      } catch (e) {
        print('Error fetching weather for $city: $e');
        continue;
      }
    }
    
    return weatherList;
  }
}
