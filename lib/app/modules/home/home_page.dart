import 'dart:async';

import 'package:eco_coleta_flutter/app/modules/home/components/filter_event_bar.dart';
import 'package:eco_coleta_flutter/app/modules/home/components/new_event_dialog.dart';
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
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  CameraPosition currentMapPosition() {
    CameraPosition position = CameraPosition(
      target: LatLng(_userLocation.latitude, _userLocation.longitude),
      zoom: 18.4746,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _userLocation == null
          ? Container(
              alignment: Alignment.center, child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  markers: _markers.values.toSet(),
                  initialCameraPosition: currentMapPosition(),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onLongPress: (value) {
                    _getAddressFromLatLng(value.latitude, value.longitude);
                    if (_currentAddress != null)
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => NewEventDialog(
                          address: _currentAddress,
                          saveEvent: () {
                            print("Ok");
                            setState(() {
                              _markers.clear();
                              final marker = Marker(
                                markerId: MarkerId("curr_loc"),
                                position: LatLng(
                                  value.latitude,
                                  value.longitude,
                                ),
                                infoWindow: InfoWindow(title: _currentAddress),
                              );
                              _markers["Current Location"] = marker;
                            });
                          },
                        ),
                      );
                  },
                ),
                FilterEventBar()
              ],
            ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            child: Icon(Icons.search),
            tooltip: "Pesquisar evento",
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
