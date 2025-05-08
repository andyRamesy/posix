import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(children: [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.posix',
      ),
      RichAttributionWidget(attributions: [
        TextSourceAttribution(
          'OpenStreetMap',
          onTap: () => print("https://openstreetmap.org/copyright"),
        ),
      ])
    ]);
  }
}
