import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonationMap extends StatefulWidget {
  const DonationMap({super.key});

  @override
  State<DonationMap> createState() => _DonationMapState();
}

class _DonationMapState extends State<DonationMap> {
  static LatLng _initialCameraPosition = LatLng(32.5749544, 74.0896053);
  Completer<GoogleMapController> _controller = Completer();
  final LatLng sourceLocation = LatLng(32.567676, 74.074312);
  final LatLng destination = LatLng(32.577826, 74.080165);
  List<Marker> _list = [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(32.567676, 74.074312),
        infoWindow: InfoWindow(title: 'Current Location')),
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(32.577826, 74.080165),
        infoWindow: InfoWindow(title: 'Second Location'))
  ];
  final String googleApi = 'AIzaSyA9KKPWiQYya6v-XOpsR6dZbM7vsM_JBBQ';

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  _addPolyline() {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApi,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(
          destination.latitude,
          destination.longitude,
        ),
        travelMode: TravelMode.driving,
      );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyline();
  }

  @override
  void initState() {
    // TODO: implement initState
_getPolyline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      polylines: Set<Polyline>.of(polylines.values),
      markers: Set<Marker>.of(_list),
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);

      },
      initialCameraPosition:
          CameraPosition(target: _initialCameraPosition, zoom: 14),
    ));
  }
}
