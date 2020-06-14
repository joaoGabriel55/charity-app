import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  Completer<GoogleMapController> _controller = Completer();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _userLocation;
  String _currentAddress;

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  CameraPosition currentMapPosition() {
    CameraPosition position = CameraPosition(
      target: LatLng(_userLocation.latitude, _userLocation.longitude),
      zoom: 14.4746,
    );
    return position;
  }

  _getCurrentLocation() async {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _userLocation = position;
      });
      if (_userLocation != null)
        _getAddressFromLatLng(_userLocation.latitude, _userLocation.longitude);
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng(latitude, longitude) async {
    try {
      List<Placemark> p =
          await geolocator.placemarkFromCoordinates(latitude, longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.subLocality}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  dialog(context, address) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment(0.0, 0.0),
              child: Text(
                address,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Got It!',
                  style: TextStyle(color: Colors.blue[900], fontSize: 16.0),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _userLocation == null
          ? Container(
              alignment: Alignment.center, child: CircularProgressIndicator())
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: currentMapPosition(),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onLongPress: (value) {
                _getAddressFromLatLng(value.latitude, value.longitude);
                if (_currentAddress != null)
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          dialog(context, _currentAddress));
              },
            ),
    );
  }
}
