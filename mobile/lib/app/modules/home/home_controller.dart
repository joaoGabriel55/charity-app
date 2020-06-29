import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  Position userLocation;

  @observable
  String currentAddress;

  @observable
  Map<String, Marker> markers;

  @observable
  Completer<GoogleMapController> controllerMap;

  Geolocator geolocator;

  _HomeControllerBase() {
    this.markers = {};
    this.controllerMap = Completer();
    this.geolocator = Geolocator()..forceAndroidLocationManager;
  }

  @action
  getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      userLocation = position;
      if (userLocation != null)
        getAddressFromLatLng(userLocation.latitude, userLocation.longitude);
    }).catchError((e) {
      print(e);
    });
  }

  @action
  getAddressFromLatLng(latitude, longitude) async {
    try {
      List<Placemark> p =
          await geolocator.placemarkFromCoordinates(latitude, longitude);
      Placemark place = p[0];
      currentAddress =
          "${place.subLocality}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }

  @action
  instantiateMarker(double latitude, double longitude) {
    this.markers.clear();
    Map<String, Marker> markers = {};
    final marker = Marker(
      markerId: MarkerId("curr_loc"),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: currentAddress),
    );
    markers["Current Location"] = marker;
    return markers;
  }
}
