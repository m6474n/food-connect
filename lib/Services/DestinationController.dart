
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DestinationController{

  static final DestinationController _destination = DestinationController._internal();

  LatLng? destination;

  factory DestinationController(){
    return _destination;
  }

  DestinationController._internal();

}