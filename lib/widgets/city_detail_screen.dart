import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/weather_model.dart';

class CityDetailScreen extends StatelessWidget {
  final String city;

  const CityDetailScreen({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Carte de la ville',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Container(
              height: 400,
              width: double.infinity,
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(48.8566, 2.3522), // Coordonnées par défaut (Paris)
                  zoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(48.8566, 2.3522),
                        builder: (ctx) => const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
