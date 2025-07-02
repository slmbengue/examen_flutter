import 'package:equatable/equatable.dart';
import '../models/weather_model.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {
  final double progress;

  const WeatherLoading({this.progress = 0.0});

  @override
  List<Object> get props => [progress];
}

class WeatherSuccess extends WeatherState {
  final List<WeatherModel> weatherList;

  const WeatherSuccess(this.weatherList);

  @override
  List<Object> get props => [weatherList];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
