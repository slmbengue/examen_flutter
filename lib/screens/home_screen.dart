import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/weather_bloc.dart';
import '../blocs/weather_event.dart';
import '../blocs/weather_state.dart';
import '../widgets/weather_progress_indicator.dart';
import '../widgets/weather_table.dart';
import '../widgets/city_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bienvenue dans l\'application météo !',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WeatherBloc>().add(FetchWeather());
                    },
                    child: const Text('Démarrer'),
                  ),
                ],
              ),
            );
          }

          if (state is WeatherLoading) {
            return WeatherProgressIndicator(progress: state.progress);
          }

          if (state is WeatherSuccess) {
            return WeatherTable(
              weatherList: state.weatherList,
              onCityTap: (city) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CityDetailScreen(city: city),
                  ),
                );
              },
            );
          }

          if (state is WeatherError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Une erreur est survenue : ${state.message}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WeatherBloc>().add(RetryWeather());
                    },
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
