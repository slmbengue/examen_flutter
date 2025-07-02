import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../blocs/weather_bloc.dart';
import '../blocs/weather_event.dart';
import '../models/weather_model.dart';

class WeatherTable extends StatelessWidget {
  final List<WeatherModel> weatherList;
  final Function(String) onCityTap;

  const WeatherTable({
    super.key,
    required this.weatherList,
    required this.onCityTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Données météo des villes',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          DataTable(
            columns: const [
              DataColumn(label: Text('Ville')),
              DataColumn(label: Text('Température')),
              DataColumn(label: Text('Description')),
              DataColumn(label: Text('Humidité')),
              DataColumn(label: Text('Vitesse du vent')),
              DataColumn(label: Text('Pression')),
            ],
            rows: weatherList.map((weather) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(weather.city),
                    onTap: () => onCityTap(weather.city),
                  ),
                  DataCell(Text('${weather.temperature}°C')),
                  DataCell(Text(weather.description)),
                  DataCell(Text('${weather.humidity}%')),
                  DataCell(Text('${weather.windSpeed} km/h')),
                  DataCell(Text('${weather.pressure} hPa')),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<WeatherBloc>().add(FetchWeather());
            },
            child: const Text('Recommencer'),
          ),
        ],
      ),
    );
  }
}
