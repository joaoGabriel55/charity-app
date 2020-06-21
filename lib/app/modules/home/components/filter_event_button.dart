import 'package:flutter/material.dart';

class FilterEventButton extends StatefulWidget {
  final Color color;
  final Function onPressed;

  const FilterEventButton(
      {Key key, @required this.color, @required this.onPressed})
      : super(key: key);

  @override
  _FilterEventButtonState createState() => _FilterEventButtonState();
}

class _FilterEventButtonState extends State<FilterEventButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: this.widget.onPressed,
      foregroundColor: Colors.white,
      backgroundColor: this.widget.color,
      child: Icon(Icons.search),
      elevation: 0,
    );
  }
}
