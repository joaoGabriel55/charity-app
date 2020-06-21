import 'package:flutter/material.dart';

class NewEventDialog extends StatelessWidget {
  final String address;
  final Function saveEvent;

  const NewEventDialog({Key key, this.address, this.saveEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
