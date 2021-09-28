import 'dart:convert';
import 'package:blinking_text/blinking_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import '../../../app_colors.dart';
import '../../../constants.dart';
import '../../../custom_text.dart';
import '../../../loading.dart';

class RecentFiles extends StatefulWidget {
  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  List list = [];
  bool vf = true;
  bool a = true;
  var recenteCommandeList = new Map();
  var commande_screen;

  Future getData() async {
    final http.Response response =
        await http.get(Uri.parse(apiCommandeRecente));
    if (response.statusCode == 200) {
      setState(() {
        list = jsonDecode(response.body);
        vf = false;
      });
    }
  }

  // var layInfo = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  showCommande(context,nomCli,addressCli,numCli,listCommandes,prixTotal) {

    List <Widget> commandes = [];
    listCommandes.forEach((element){
      commandes.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: element['nomPlat'], size: 1.5.w, color: black),
          CustomText(text: element['quantite'].toString(), size: 1.5.w, color: black),
        ],
      ));
    });
    commandes.add(CustomText(text: "Prix total : " + prixTotal.toString() + " FCFA", size: 1.5.w, color: black));
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Stack(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.5,
                    margin: EdgeInsets.only(top: 6.h),
                    decoration: BoxDecoration(
                      color: white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10,
                          offset: Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child:  Padding(
                      padding: EdgeInsets.only(top: 15.h,left: 1.h,right: 1.h,bottom: 1.h),
                      child: Column(
                        children: [
                          Text(
                            nomCli,
                            style: TextStyle(
                              color: black,
                              fontSize: 3.h,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            addressCli,
                            style: TextStyle(
                              color: black,
                            ),),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            numCli,
                            style: TextStyle(
                              color: black,
                            ),),
                          SizedBox(
                            height: 5.h,
                          ),
                        Padding(
                              padding: EdgeInsets.only(left: 4.w,right: 4.w),
                              child: Column(
                                children: commandes,
                              ),
                            )
                        ],
                      ),
                    )
                ),
                Positioned(
                    top: 0,
                    left: 16,
                    right: 16,
                    child: CircleAvatar(
                      radius: 10.h,
                      backgroundColor: blueFont,
                    )
                )
              ],
            ),
          );
        }
    );
  }

  DataRow listesDesCommandes(Map infoCommande) {
    return DataRow(
      cells: [
        DataCell(
            Row(
              children: [
                SvgPicture.asset("assets/icons/unknown.svg"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Expanded(
                    child: Text(
                      infoCommande['userInfo']['nom'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 1.6.h,
                        fontWeight: FontWeight.bold,
                        color: SideMenuColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              showCommande(context,
                  infoCommande['userInfo']['nom'],
                  infoCommande['userInfo']['tel'],
                  infoCommande['userInfo']['adresse'],
                  infoCommande['commandeInfo'],
                  infoCommande['prixTotal'],
              );
            }

            ),
        DataCell(
          Row(
            children: [
              Text(
                infoCommande['typeLivraison'],
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: SideMenuColor),
              ),
            ],
          ),
            onTap: () {
              showCommande(context,
                infoCommande['userInfo']['nom'],
                infoCommande['userInfo']['tel'],
                infoCommande['userInfo']['adresse'],
                infoCommande['commandeInfo'],
                infoCommande['prixTotal'],
              );
            }
        ),
        DataCell(
          BlinkText(
            infoCommande['commandeInfo'][0]['id'].toString() + " min",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            beginColor: Colors.black,
            endColor: Colors.red,
            duration: Duration(seconds: 2),
            // times: 10,
          ),
            onTap: () {
              showCommande(context,
                infoCommande['userInfo']['nom'],
                infoCommande['userInfo']['tel'],
                infoCommande['userInfo']['adresse'],
                infoCommande['commandeInfo'],
                infoCommande['prixTotal'],
              );
            }
        ),
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, offset: Offset(0, 3), blurRadius: 24)
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Commandes en attente...",
            style: TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          vf
              ? Center(child: Loading())
              : SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: 1,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text(
                    "Nom client",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                DataColumn(
                  label: Text(
                      "Type de livraison",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                ),
                DataColumn(
                  label: Text(
                      "Heure",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                ),
              ],
              rows: List.generate(
                list.length,
                    (index) => listesDesCommandes(list[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      commande_screen = buildContainer();
    }
    return commande_screen;
  }
}

/*
class Draggablelist extends StatefulWidget {
  const Draggablelist({Key? key}) : super(key: key);

  @override
  _DraggablelistState createState() => _DraggablelistState();
}

class _DraggablelistState extends State<Draggablelist> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          // color: Colors.blue[100],
          child: ListView.builder(
            controller: scrollController,
            itemCount: 25,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text('Item $index'));
            },
          ),
        );

      },
    );
  }
}
*/
