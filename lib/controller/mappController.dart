import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:food_donation_app/Services/DestinationController.dart';
import 'package:food_donation_app/Services/SourceController.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:food_donation_app/Services/LocationManager.dart';
import 'package:food_donation_app/controller/routeController.dart';
import 'package:food_donation_app/views/screens/dashboards/dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart' as location;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

import '../components/GradientButton.dart';
import '../utility/constants.dart';

class MapController extends GetxController {
  final Completer<GoogleMapController> completer = Completer();
  LatLng initialCamera = LatLng(32.5749276,74.007203);
  final FirebaseFirestore ref = FirebaseFirestore.instance;
  final TextEditingController searchController = TextEditingController();
  bool startTraveling = false;

  bool isRouteStarted = false;
  bool isDonationPicked = false;

//
  Position? currentLocation;

//
  List<Marker> points = [
    Marker(markerId: MarkerId('Source'),position: LatLng(SourceController().source!.latitude,SourceController().source!.longitude), infoWindow: InfoWindow(title: 'Source')),
    Marker(markerId: MarkerId('2'),position: DestinationController().destination!  ,infoWindow: InfoWindow(title: 'Destination'))

  ];
  // CameraPosition movingCameraPosition = CameraPosition(target: LatLng(0, 0));
  var id = DateTime.now().microsecondsSinceEpoch;
  List<LatLng> polylineCoordinates = [];

  final TextEditingController markerTitleController = TextEditingController();
  // PointLatLng? source;
  // PointLatLng? destination;
  Stream RouteStream =
  FirebaseFirestore.instance.collection('Route').snapshots();
// load map to frontend
  loadMap() {
    return StreamBuilder(
      stream: RouteStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // for (int i = 0; i < snapshot.data!.docs.length; i++) {
        //   points.add(Marker(
        //       markerId: MarkerId(
        //         i.toString(),
        //       ),
        //       position: LatLng(snapshot.data!.docs[i]['lat'],
        //           snapshot.data!.docs[i]['long']),
        //       infoWindow:
        //       InfoWindow(title: snapshot.data!.docs[i]['title'])));
        // }
        return GoogleMap(
            markers: Set<Marker>.from(points),
            polylines: {
              Polyline(
                  polylineId: PolylineId('Route'),
                  points: polylineCoordinates,
                  width: 6,
                  color: Colors.deepPurple)
            },
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              completer.complete(controller);
            },
            initialCameraPosition:
            CameraPosition(target: initialCamera, zoom: 12));
      },
    );
  }

  /// Generate route
  ///


// animate camera to current location
  moveToCurrentLocation() async {
    await getCurrentLocation().then((value) async {
      // searchController.text = value.toString();

      initialCamera = LatLng(value.latitude, value.longitude);
      CameraPosition newCameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 12);
      GoogleMapController controller = await completer.future;
      controller
          .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));

    });

    update();
  }

//add marker to database


  // addCurrentLocationMarker(
  //     double lat,
  //     double long,
  //     String address,
  //     ) {
  //   ref.collection('markers').doc('1').set({
  //     "id": id,
  //     'lat': lat,
  //     'long': long,
  //     'address': address,
  //     'info': 'My Location'
  //   });
  // }
//update current Location

  updatecurrentLocation(
      double lat,
      double long,
      String address,
      ) {
    ref.collection('markers').doc('1').update(
        {'lat': lat, 'long': long, 'address': address, 'info': 'My Location'});
  }



// Get Location Permissions
  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
          'Location permission disabled!', 'Turn on the location service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Permission Denied', 'Turn on the location service');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Location permissions are permanently denied',
          'We can not request the permissions');
    }
    return await Geolocator.getCurrentPosition();
  }

  getLocation(){
    getCurrentLocation().then((value)async{

      initialCamera = LatLng(value.latitude, value.longitude);
      CameraPosition newCameraPosition = CameraPosition(target: LatLng(value.latitude, value.longitude), zoom: 12);
      GoogleMapController controller = await completer.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));

        points.add(Marker(markerId: MarkerId('Source'), position: value,));
        update();
      // Camera


    });
  }
// RouteController routeController = Get.put(RouteController());
// polyline service
   getPolyPoints() async {
    PolylinePoints polylinePoints = new PolylinePoints();
PointLatLng Source = PointLatLng(SourceController().source!.latitude, SourceController().source!.longitude);
PointLatLng Destination = PointLatLng(DestinationController().destination!.latitude,DestinationController().destination!.longitude);
print(Source);
print(Destination);
// PolylineRequest request = PolylineRequest(
  
//   mode: TravelMode.driving, origin: Source, destination: Destination,
// );
PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: "AIzaSyCGXjH2olWHaRbJBH4SRNGmYfX60skyWs8",
        request: PolylineRequest(
        origin: PointLatLng(32.5650722,74.058639),
        destination: PointLatLng(32.470832, 73.983826),
  
        mode: TravelMode.driving,
        // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")],
        ),
);
// PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//   googleApiKey:"AIzaSyCGXjH2olWHaRbJBH4SRNGmYfX60skyWs8" ,
  
//   request: request);

        // 'AIzaSyCGXjH2olWHaRbJBH4SRNGmYfX60skyWs8', Source, Destination);

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
    }

    print(polylineCoordinates);
    update();
  }

  @override
  void onInit()
  {
    moveToCurrentLocation();
    getPolyPoints();

// getPolyPoints();
     // Get.find<RouteController>().getSource();
     // getLocation();
     // updateCameraLocation();
    super.onInit();
  }
RouteController  route = Get.put(RouteController());

  // Move camera location
  updateCameraLocation() {
    Geolocator.getPositionStream().listen((Position _newPosition) async {

      currentLocation = _newPosition;
      CameraPosition newCameraPosition = CameraPosition(
          target: LatLng(
            _newPosition.latitude,
            _newPosition.longitude,
          ),
          zoom: 14);
      GoogleMapController controller = await completer.future;
      controller
          .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
      points.add(Marker(
          markerId: const MarkerId('1'),
        icon:  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: LatLng(_newPosition.latitude, _newPosition.longitude),
          infoWindow: const InfoWindow(title: 'My Location')));
      update();
    });
  }
//get destination

  // // Search Places
  //
  // var uuid = Uuid();
  // String _sessionToken = "112233";
  // List<dynamic> placeList = [];
  //
  // onChanged() {
  //   if (_sessionToken == null) {
  //     _sessionToken = uuid.v4();
  //     update();
  //   }
  //   getSuggestions(searchController.text);
  // }
  //
  // getSuggestions(String input) async {
  //   String apiKey = "AIzaSyCGXjH2olWHaRbJBH4SRNGmYfX60skyWs8";
  //   String baseUrl =
  //       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  //   String request =
  //       '$baseUrl?input=$input&key=$apiKey&sessiontoken=$_sessionToken';
  //
  //   var response = await http.get(Uri.parse(request));
  //
  //   print(response.body.toString());
  //
  //   if (response.statusCode == 200) {
  //     placeList = jsonDecode(response.body.toString())['predictions'];
  //   } else {
  //     throw Exception("Failed to get data");
  //   }
  //
  //   update();
  // }

  //// Reviews

  getReviews(BuildContext context,String id,String restaurantId, String restaurantName){
    double rating = 0.0;

    return showDialog(context: context, builder: (_){
      return AlertDialog(
          title: Text('Review Donation', style: paragraph.copyWith(color: mainColor, fontSize: 20, fontWeight: FontWeight.bold),),
          content: Container(height: 120,child: Column(children: [
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40.0,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (value) {

                rating = value;
                update();
              },
            ),
            SizedBox(height: 20),
            GradientButton(label: "Submit", onPress: (){

              storeReview(restaurantId, rating, restaurantName);
              updateDonationStatus(id);
              Get.to(()=>DashboardScreen());
              Get.delete<MapController>();
            }, loading: false)
          ],),)

      );
    });
  }

  // Store review to firebase

  storeReview(String id,double rating, String restaurant ){
    FirebaseFirestore.instance.collection('reviews').add({
      "rating": rating.toString(),
      "id": id,
      "from": FirebaseAuth.instance.currentUser!.displayName.toString(),
      "to": restaurant

    }).then((value) {
      EasyLoading.showSuccess("Submitted",);
    });
    update();
  }
  updateDonationStatus(String id){
    FirebaseFirestore.instance.collection("donations").doc(id).update({
      "status": "completed"
    });
  }







@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  searchController.dispose();
  completer.complete();

  }

}
