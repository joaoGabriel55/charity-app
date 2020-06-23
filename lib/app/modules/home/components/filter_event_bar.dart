import 'package:eco_coleta_flutter/app/modules/home/components/filter_event_button.dart';
import 'package:flutter/material.dart';

class FilterEventBar extends StatefulWidget {
  @override
  _FilterEventBarState createState() => _FilterEventBarState();
}

class _FilterEventBarState extends State<FilterEventBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 104.0,
      right: 0.0,
      height: 100,
      child: Card(
          elevation: 8.0,
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))),
          child: Container(
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(width: 18),
              FilterEventButton(
                onPressed: () {},
                color: Colors.yellow[700],
              ),
              Container(width: 18),
              FilterEventButton(
                onPressed: () {},
                color: Colors.green[700],
              ),
              Container(width: 18),
              FilterEventButton(
                onPressed: () {},
                color: Colors.purpleAccent[700],
              ),
              Container(width: 18),
              FilterEventButton(
                onPressed: () {},
                color: Colors.blue[700],
              ),
              Container(width: 8),
            ],
          ))),
    );
  }
}
