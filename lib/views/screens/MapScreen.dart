import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  static const LatLng _initialPosition = LatLng(32.5319239,74.0880223);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 12),),);
  }
}
