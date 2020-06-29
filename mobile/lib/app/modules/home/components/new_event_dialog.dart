import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewEventDialog extends StatelessWidget {
  final String address;
  final Function saveEvent;

  const NewEventDialog({Key key, this.address, this.saveEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.all(48),
          child: Container(
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
                      saveEvent();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Got It!',
                      style: TextStyle(color: Colors.blue[900], fontSize: 16.0),
                    ))
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80.0,
                width: 80.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: null,
                    child: Image.asset('assets/images/add_event.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
