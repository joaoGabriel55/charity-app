import 'package:flutter/material.dart';

class FilterEventButton extends StatefulWidget {
  final Color color;
  final Function onPressed;
  final String icon;
  final String tooltip;

  const FilterEventButton(
      {Key key,
      @required this.color,
      @required this.onPressed,
      this.icon,
      this.tooltip})
      : super(key: key);

  @override
  _FilterEventButtonState createState() => _FilterEventButtonState();
}

class _FilterEventButtonState extends State<FilterEventButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: this.widget.tooltip,
      onPressed: this.widget.onPressed,
      foregroundColor: Colors.white,
      backgroundColor: this.widget.color,
      child: new Image.asset(
        'assets/images/${this.widget.icon}.png',
        height: 38,
        width: 38,
        filterQuality: FilterQuality.high,
      ),
      elevation: 0,
    );
  }
}
