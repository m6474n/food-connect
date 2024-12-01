
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SourceController{

  static final SourceController _source = SourceController._internal();

  LatLng? source;

  factory SourceController(){
    return _source;
  }

  SourceController._internal();

}