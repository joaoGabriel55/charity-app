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
      height: 108,
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
          margin: EdgeInsets.only(top: 8),
          child: Stack(
            children: [
              ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(width: 18),
                  FilterEventButton(
                    icon: "food",
                    tooltip: "Distribuição de alimentos",
                    onPressed: () {},
                    color: Colors.yellow[700],
                  ),
                  Container(width: 18),
                  FilterEventButton(
                    icon: "shirt",
                    tooltip: "Doações de vestimentas",
                    onPressed: () {},
                    color: Colors.green[700],
                  ),
                  Container(width: 18),
                  FilterEventButton(
                    icon: "culture",
                    tooltip: "Eventos culturais",
                    onPressed: () {},
                    color: Colors.purpleAccent[700],
                  ),
                  Container(width: 18),
                  FilterEventButton(
                    icon: "sports",
                    tooltip: "Eventos esportivos",
                    onPressed: () {},
                    color: Colors.blue[700],
                  ),
                  Container(width: 8),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "Selecionar tipo de Ação",
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
