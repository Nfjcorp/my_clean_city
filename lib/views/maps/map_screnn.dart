import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScrenn extends StatefulWidget {
  const MapScrenn({super.key});

  @override
  State<MapScrenn> createState() => _MapPageState();
}

class _MapPageState extends State<MapScrenn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center() /* GoogleMap(
       // initialCameraPosition: CameraPosition(),
            ) */
    );
  }
}
