import 'package:eco_coleta_flutter/app/modules/home/components/filter_event_bar.dart';
import 'package:eco_coleta_flutter/app/modules/home/components/new_event_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void initState() {
    controller.getCurrentLocation();
    super.initState();
  }

  CameraPosition currentMapPosition() {
    CameraPosition position = CameraPosition(
      target: LatLng(
        controller.userLocation.latitude,
        controller.userLocation.longitude,
      ),
      zoom: 18.4746,
    );
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (controller.userLocation == null)
        return Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
          ),
        );
      return Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              markers: controller.markers.values.toSet(),
              initialCameraPosition: currentMapPosition(),
              onMapCreated: (GoogleMapController gMapController) {
                controller.controllerMap.complete(gMapController);
              },
              onLongPress: (value) {
                controller.getAddressFromLatLng(
                  value.latitude,
                  value.longitude,
                );
                if (controller.currentAddress != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => NewEventDialog(
                      address: controller.currentAddress,
                      saveEvent: () {
                        controller.markers = controller.instantiateMarker(
                          value.latitude,
                          value.longitude,
                        );
                      },
                    ),
                  );
                }
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
    });
  }
}
