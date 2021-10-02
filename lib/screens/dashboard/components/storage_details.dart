import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/custom_text.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'storage_info_card.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class StarageDetails extends StatefulWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<StarageDetails> createState() => _StarageDetailsState();
}

class _StarageDetailsState extends State<StarageDetails> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),

          boxShadow: const [
            BoxShadow(
                color: Colors.grey, offset: Offset(0, 3), blurRadius: 4)
          ]),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: "Liste des clients",
                  size: 20,
                  color: Colors.black54),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(defaultPadding),
                  ),
                ),
                child: Notice(),

              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: "Clients",
                      size: 15,
                      color: Colors.blueAccent),
                  TextButton.icon(onPressed: (){},
                      icon: Icon(Icons.arrow_drop_down,color: Colors.blueAccent,),
                    label: CustomText(
                      text: "Tous",
                      size: 15,
                      color: Colors.blueAccent,
                    ),

                  ),

                ],
              ),
              Divider(
                color: Colors.blueAccent.withOpacity(0.15),
              ),
              SizedBox(height: defaultPadding),
              Container(
                child: Column(
                  children: [
                    StorageInfoCard(
                        nom: "User",
                        icon: Icons.arrow_forward_ios_outlined),
                    StorageInfoCard(
                        nom: "User",
                        icon: Icons.arrow_forward_ios_outlined),
                    StorageInfoCard(
                        nom: "User",
                        icon: Icons.arrow_forward_ios_outlined),
                    StorageInfoCard(
                        nom: "User",
                        icon: Icons.arrow_forward_ios_outlined),
                    StorageInfoCard(
                        nom: "User",
                        icon: Icons.arrow_forward_ios_outlined),
                    StorageInfoCard(
                        nom: "User",
                        icon: Icons.arrow_forward_ios_outlined),
                    StorageInfoCard(
                        nom: "User",
                        icon: Icons.arrow_forward_ios_outlined),
                    StorageInfoCard(
                        nom: "User",
                        icon: Icons.arrow_forward_ios_outlined),
                    StorageInfoCard(
                        nom: "User",
                        icon: Icons.arrow_forward_ios_outlined),

                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TileCard extends StatefulWidget {
  const TileCard({Key? key}) : super(key: key);

  @override
  _TileCardState createState() => _TileCardState();
}

class _TileCardState extends State<TileCard> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(

      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
            child: ExpansionTileCard(
              baseColor: Colors.cyan[50],
              expandedColor: Colors.red[50],
              key: cardA,
              leading: CircleAvatar(
                  child: Image.asset("assets/images/profile_pic.png")),
              title: Text("Notice..."),
              subtitle: Text("EVANNAISSANCE DEVELOPMENT COMPANY"),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      "Cette section est reservé à tous les clients enregistré et/ou à votre service."
                          "Cliquer sur un contact pour afficher les details, cliquer sur plus '+' afin d'afficher toute la liste",

                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 16),
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                        cardA.currentState?.expand();
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.arrow_downward),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Open'),
                        ],
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                        cardA.currentState?.collapse();
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.arrow_upward),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Close'),
                        ],
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.swap_vert),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Toggle'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Notice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildItem(String label) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(label),
      );
    }

    buildNotice() {
      return Column(
        children: <Widget>[
          Text("Vous retrouverez ici la liste de certain clients.\n"
              "Cliquer pour afficher les détails d'un client.\n"
              "'Tous' pour afficher la liste de tous les clients",
            style: TextStyle(fontSize: 15),)
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ScrollOnExpand(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: true,
                      hasIcon: false,
                    ),
                    header: Container(
                      color: Color(0xb7073662),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                expandIcon: Icons.arrow_right,
                                collapseIcon: Icons.arrow_drop_down,
                                iconColor: Colors.white,
                                iconSize: 28.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(right: 5),
                                hasIcon: false,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Notice",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    collapsed: Container(),
                    expanded: Container(
                      color: Color(0x581fafee),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildNotice(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}