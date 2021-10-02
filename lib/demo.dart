import 'package:allo_thieb/help/app_colors.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class ExpansionTileCardDemo extends StatefulWidget {

  @override
  _ExpansionTileCardDemoState createState() => _ExpansionTileCardDemoState();
}

class _ExpansionTileCardDemoState extends State<ExpansionTileCardDemo> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: red,
      child: ExpansionCard(
        borderRadius: 20,
        background: Image.asset(
          "assets/images/asia.jpg",
          width: 600,
          fit: BoxFit.cover,
        ),
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Header",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
            child: Text("Content goes over here !",
                style: TextStyle(fontSize: 20, color: Colors.black)),
          )
        ],
      )
    );

  }
}


