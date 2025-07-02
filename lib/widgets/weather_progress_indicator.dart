import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeatherProgressIndicator extends StatelessWidget {
  final double progress;

  const WeatherProgressIndicator({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          const SpinKitDoubleBounce(
            color: Colors.blue,
            size: 50.0,
          ),
          const SizedBox(height: 20),
          Text(
            _getProgressMessage(progress),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  String _getProgressMessage(double progress) {
    if (progress < 0.3) {
      return 'Nous téléchargeons les données...';
    } else if (progress < 0.6) {
      return 'C\'est presque fini...';
    } else {
      return 'Plus que quelques secondes avant d\'avoir le résultat...';
    }
  }
}
