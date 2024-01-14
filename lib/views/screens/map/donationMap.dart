// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:food_donation_app/utility/constants.dart';
// import 'package:google_map_polyline_new/google_map_polyline_new.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class DonationMap extends StatefulWidget {
//   const DonationMap({super.key});
//
//   @override
//   State<DonationMap> createState() => _DonationMapState();
// }
//
// class _DonationMapState extends State<DonationMap> {
//   LatLng source = LatLng(32.567378, 74.066529);
//   LatLng destination =LatLng(32.544797, 74.085455);
//
//   List<Marker> _list = [
//     Marker(
//         markerId: MarkerId('1'),
//         position: LatLng(32.567378, 74.066529),
//         infoWindow: InfoWindow(title: 'Source Location')),
//     Marker(
//         markerId: MarkerId('2'),
//         position: LatLng(32.544797, 74.085455),
//         infoWindow: InfoWindow(title: 'Destination Location'))
//   ];
//
//   final LatLng initialPosition = LatLng(32.568870, 74.073021);
//   Set<Polyline> polyline = {};
//
//   List<LatLng> routeCoords  ;
//   GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: GoogleMapApi);
//     getSomePoints()async{
//       routeCoords = await googleMapPolyline.getCoordinatesWithLocation(origin: source, destination: destination, mode:RouteMode.driving);
//     }
//     @override
//   void setState(VoidCallback fn) {
//     // TODO: implement setState
//
//       getSomePoints();
//
//     super.setState(fn);
//   }
//
// GoogleMapController? _controller ;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//           markers: Set<Marker>.of(_list),
//           onMapCreated: onMapCreated,
//           initialCameraPosition:
//           CameraPosition(target: initialPosition, zoom: 14.5)),
//     );
//   }
//
//
//   void onMapCreated(GoogleMapController controller) {
//     setState(() {
//       _controller = controller;
//       polyline.add(Polyline(polylineId: PolylineId('route'),
//       visible: true,
//         points: routeCoords,
//         width: 4,
//         color: Colors.blue
//
//       ));
//
//     });
//   }
// }