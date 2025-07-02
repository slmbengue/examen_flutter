import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import 'weather_event.dart';
import 'weather_state.dart';

import 'dart:async';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService _weatherService = WeatherService();
  Timer? _timer;
  static const Duration _updateInterval = Duration(seconds: 5);

  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<RetryWeather>(_onRetryWeather);
    
    // Démarrer les appels API périodiques
    _startPeriodicUpdates();
  }

  void _startPeriodicUpdates() {
    _timer = Timer.periodic(_updateInterval, (timer) {
      if (state is WeatherSuccess) {
        add(FetchWeather());
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weatherList = await _weatherService.getWeatherForAllCities();
      emit(WeatherSuccess(weatherList));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  void _onRetryWeather(RetryWeather event, Emitter<WeatherState> emit) {
    add(FetchWeather());
  }
}
