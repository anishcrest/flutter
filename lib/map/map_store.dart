import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'map_store.g.dart';

class MapStore = _MapStore with _$MapStore;

abstract class _MapStore with Store {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // For controlling the view of the Map
  late GoogleMapController mapController;

  // For storing the current position
  @observable
  Position? currentPosition;

  @observable
  String currentAddress = '';

  @observable
  String startAddress = '';

  @observable
  String destinationAddress = '';

  @observable
  String? placeDistance;

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  @observable
  ObservableSet<Marker> markers = ObservableSet();

  @observable
  ObservableMap<PolylineId, Polyline> polylines = ObservableMap();

  @observable
  ObservableList<LatLng> polylineCoordinates = ObservableList();

  @action
  geCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) async {
      currentPosition = value;

      print('CURRENT POS: $currentPosition');

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              value.latitude,
              value.longitude,
            ),
            zoom: 12,
          ),
        ),
      );

      await getAddress();
    }).catchError((e) {
      print('Error during current location fetch ---->${e.toString()}');
    });
  }

  @action
  Future getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);

      // Taking the most probable result
      Placemark place = p[0];

      // Structuring the address
      currentAddress =
          "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";

      // Update the text of the TextField
      startAddressController.text = currentAddress;

      // Setting the user's present location as the starting address
      startAddress = currentAddress;
    } catch (e) {
      print('Error during getAddress-------------->${e.toString()}');
    }
  }

  // Method for calculating the distance between two places
  @action
  Future<bool> calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Location>? startPlacemark = await locationFromAddress(startAddress);
      List<Location>? destinationPlacemark =
          await locationFromAddress(destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = startAddress == currentAddress
          ? currentPosition!.latitude
          : startPlacemark[0].latitude;

      double startLongitude = startAddress == currentAddress
          ? currentPosition!.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude,$startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude,$destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: startAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      // Calculating to check that the position relative
      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100,
        ),
      );

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      placeDistance = totalDistance.toStringAsFixed(2);

      return true;
    } catch (e) {
      print('Error during calculateDistance-------------->${e.toString()}');
      throw e;
    }
  }

  // Create the polylines for showing the route between two places
  @action
  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    try {
      print(
        'START COORDINATES : ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES : ($destinationLatitude, $destinationLongitude)',
      );

      // Initializing PolylinePoints
      PolylinePoints polylinePoints = PolylinePoints();

      // Generating the list of coordinates to be used for
      // drawing the polylines
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyCtimJDQVTlp6HzHs1jEWGBJw2tJzhmrHQ', // Google Maps API Key
        PointLatLng(startLatitude, startLongitude),
        PointLatLng(destinationLatitude, destinationLongitude),
        travelMode: TravelMode.bicycling,
      );

      print(result.points.length);

      result.points.forEach((element) {
        print(element.toString());
      });

      // Adding the coordinates to the list
      if (result.points.isNotEmpty) {
        result.points.forEach((point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }

      // Defining an ID
      PolylineId id = PolylineId('poly');

      // Initializing Polyline
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 3,
      );

      // Adding the polyline to the map
      polylines[id] = polyline;

      //print(polylines.length);

    } catch (e) {
      print('ERROR OIS HAT ${e.toString()}');
    }
  }

  @action
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
