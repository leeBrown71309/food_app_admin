import 'dart:convert';
import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/constants.dart';
import 'package:allo_thieb/help/custom_text.dart';
import 'package:allo_thieb/help/loading.dart';
import 'package:allo_thieb/help/onHoverbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:sizer/sizer.dart';
import '../../responsive.dart';
import 'ListPlatsInfos.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class ListPlats extends StatefulWidget {
  const ListPlats({Key? key}) : super(key: key);

  @override
  _ListPlatsState createState() => _ListPlatsState();
}

class _ListPlatsState extends State<ListPlats> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          SizedBox(height: defaultPadding),
          Responsive(
            Mobile: ListPlatCardGridView(
              crossAxisCount: _size.width < 850 ? 2 : 4,
              childAspectRatio: _size.width < 850 && _size.width > 350 ? 0.8 : 1,
            ),
            Tablet: ListPlatCardGridView(
              crossAxisCount: _size.width < 1100 ? 3 : 4,
              childAspectRatio: _size.width < 1100 && _size.width > 850 ? 0.9 : 0.9,
            ),
            Desktop: ListPlatCardGridView(
              childAspectRatio: _size.width < 1400 && _size.width > 1100 ? 1 : 1,
            ),
          ),
        ],
      ),
    );
  }
}

class ListPlatCardGridView extends StatefulWidget {
  const ListPlatCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<ListPlatCardGridView> createState() => _ListPlatCardGridView();
}

class _ListPlatCardGridView extends State<ListPlatCardGridView> {

  var list = [];
  bool vf = true;
  var cardImage = 'https://source.unsplash.com/random/800x600?Food';

  Future getData() async {
    final http.Response response = await http.get(Uri.parse(apiPlat_get));
    if (response.statusCode == 200) {
      setState(() {
        vf = false;
      });
      list = jsonDecode(response.body);
    } else {
      list = ["R.A.S"];
    }
  }

  popUpError() {
    return NAlertDialog(
      title: Text("Attention!"),
      content: Text("Echec de connexion"),
      blur: 2,
    ).show(context, transitionType: DialogTransitionType.Bubble);
  }

  Widget ListPlatbuildGridView() {
    return vf
        ? Center(child: Loading())
        : list[0] == "R.A.S"
        ? popUpError()
        : SafeArea(
          child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: widget.childAspectRatio,
      ),
         itemBuilder: (context, index) =>  FocusedMenuHolder(
           menuItems: [
             FocusedMenuItem(
               title: Text('Ouvrir'),
               trailingIcon: Icon(Icons.open_in_new),
               onPressed: () {},
             ),
             FocusedMenuItem(
               title: Text('Modifier'),
               trailingIcon: Icon(Icons.edit),
               onPressed: (){},
             ),
             FocusedMenuItem(
               title: Text('Supprimer', style: TextStyle(color: Colors.white)),
               trailingIcon: Icon(Icons.delete_forever, color: Colors.white),
               backgroundColor: Colors.red,
               onPressed: () {},
             ),
           ],
           blurSize: 8,
           blurBackgroundColor: Colors.black54,
           menuWidth: MediaQuery.of(context).size.width * 0.5,
           menuItemExtent: 50,
           duration: Duration(seconds: 0),
           animateMenuItems: true,
           menuOffset: 12,
           openWithTap: true,
           onPressed: () {},
           child: Container(
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20)
             ),
             child: OnHoverCard(
               child: Card(
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10)
                   ),
                   clipBehavior: Clip.antiAlias,
                   elevation: 3.0,
                   shadowColor: Color(0x8811b1e7),
                   child: Column(
                     mainAxisSize:MainAxisSize.min,
                     children: [
                       Container(
                         height: 20.h,
                         child: Stack(

                           children: [
                             Ink.image(
                               //image plat
                               image:  NetworkImage(cardImage),
                               fit: BoxFit.cover,
                             ),
                           ],
                         ),
                       ),
                       Container(
                         padding: EdgeInsets.only(top: 10,left: 16,right: 16,),
                         alignment: Alignment.center,
                         child: Column(
                           mainAxisSize:MainAxisSize.min,
                           children: [
                             Text(list[index]["nomPlat"],
                               style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                               overflow: TextOverflow.ellipsis,),
                           ],
                         ),
                       ),
                       Align(
                           alignment: Alignment.center,
                           child: Padding(
                             padding: const EdgeInsets.all(16),
                             child: Column(
                               children: [
                                 Text("Prix : ${list[index]["prix"]} FCFA",),

                                 //essaie de faire en sorte qu'on puisse afficher aussi la quantité
                               ],
                             ),
                           )),
                     ],
                   )),
             ),
           )
           /*
           PlatCard(
             info: list[index],
             isEditing: false,
           ),

            */
             ),
           ),
         );
  }
/*
  Widget ListPlatbuildGridView() {
    return vf
        ? Center(child: Loading())
        : list[0] == "R.A.S"
            ? popUpError()
            : GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding,
                  childAspectRatio: widget.childAspectRatio,
                ),
                itemBuilder: (context, index) => FocusedMenuHolder(
                    menuWidth: MediaQuery.of(context).size.width * 0.50,
                    blurSize: 5.0,
                    menuItemExtent: 45,
                    menuBoxDecoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    duration: Duration(milliseconds: 100),
                    animateMenuItems: true,
                    blurBackgroundColor: Colors.black54,
                    bottomOffsetHeight: 100,
                    openWithTap: true,
                    menuItems: <FocusedMenuItem>[
                      FocusedMenuItem(
                          title: Text(
                            "Open",
                            style: TextStyle(color: black),
                          ),
                          trailingIcon: Icon(
                            Icons.open_in_new,
                            color: black,
                          ),
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenTwo()));
                          }),
                      FocusedMenuItem(
                          title: Text(
                            "Share",
                            style: TextStyle(color: black),
                          ),
                          trailingIcon: Icon(Icons.share, color: black),
                          onPressed: () {}),
                      FocusedMenuItem(
                          title: Text(
                            "Favorite",
                            style: TextStyle(color: black),
                          ),
                          trailingIcon:
                              Icon(Icons.favorite_border, color: black),
                          onPressed: () {}),
                      FocusedMenuItem(
                          title: Text(
                            "Delete",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          trailingIcon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {}),
                    ],
                    onPressed: () {},
                    child: Card(
                      child: PlatCard(
                        info: list[index],
                        isEditing: false,
                      ),
                    )
                ),
              );
  }
*/
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListPlatbuildGridView();
  }
}
