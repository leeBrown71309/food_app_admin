import 'dart:convert';
import 'package:allo_thieb/help/apiGetPost.dart';
import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/constants.dart';
import 'package:allo_thieb/help/custom_text.dart';
import 'package:allo_thieb/help/loading.dart';
import 'package:allo_thieb/help/onHoverbutton.dart';
import 'package:allo_thieb/models/Plats/list_plats_infos.dart';
import 'package:allo_thieb/screens/main/main_screen.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:sizer/sizer.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import '../../../demo.dart';
import '../../../main.dart';
import '../../../responsive.dart';
import '../dashboard_screen.dart';


var nom_du_menu = "Menu du jour : ";
List laList = [];

class FileInfoCardGridView extends StatefulWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;


  @override
  State<FileInfoCardGridView> createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {

  var list = [];
  bool verify = true;
  Future getData() async {
    final http.Response response = await http.get(Uri.parse(apiMenuDuJour_get));
    if (response.statusCode == 200) {
      list = jsonDecode(response.body);
      setState(() {
        verify = false;
        nom_du_menu = "Menu du jour : " + list[0]['libelle'];
      });
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

  ListPlatbuildGridView() {
    return verify
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
        itemBuilder: (context, index) => FileInfoCard(info: list[index]),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty){
      return Loading();
    }
    return ListPlatbuildGridView();
  }
}
//**************************************************************************
//**************************************************************************
class MyFiles extends StatefulWidget {

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  TextEditingController libelleController = TextEditingController();
  List list1 = [];
  bool isSelected = false;
  bool vf = true;
  var libelle;

  Future getData() async {
    final http.Response response = await http.get(Uri.parse(apiPlat_get));
    if (response.statusCode == 200) {
      list1 = jsonDecode(response.body);
      setState(() {
        vf = false;
      });
    } else {
      list1 = ["R.A.S"];
    }
  }

  _insert(List data, String libelle) {
    var values = {
      'listPlats': data,
      'libelle': libelle,
    };
    var req = CallApiPost();
    req.postData(values, apiMenuDuJour_post);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Editer le menu du jour",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: 6.sp),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xb7073662),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        controller: libelleController,
                        onChanged: (value) => setState(() => libelle = value),
                        validator: (value) =>
                        value!.isEmpty ? "Entrer le nom du plat" : null,
                        style: TextStyle(
                          color: SideMenuColor1,
                        ),
                        decoration: inputDecorationNomMenu,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            content: Container(
                height: (_size.height * 80) / 100,
                width: (_size.width * 80) / 100,
                child: PopUpSelect(list: list1)),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                      color: Color(0xb7073662),
                      onPressed: () {
                        List data = [];
                        laList.forEach((element) {
                          if (element.selection) {
                            element.info['quantite'] =
                                int.parse(element.quantiteController.text);
                            print(element.info['quantite']);
                            data.add(element.info);
                          }
                        });
                        _insert(data, libelleController.text);
                        Navigator.of(context).pop();
                        var screen_refresh = MainScreen();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    buildMaterialApp(context, screen_refresh)));
                        setState(() {
                          screen_refresh.screen = DashboardScreen();
                          nom_du_menu =
                              "Menu du jour : " + libelleController.text;
                        });
                        laList = [];
                      },
                      child: new Text("Ok")),
                  SizedBox(
                    width: 1.w,
                  ),
                  RaisedButton(
                    elevation: 2,
                    color: Colors.white,
                    child: new Text("Close",
                        style: TextStyle(
                          color: Color(0xb7073662),
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          );
        },
      );
    }
    //-----------------------------------------------------------
    //-----------------------------------------------------------
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3),

                boxShadow: const [
                BoxShadow(
                    color: Colors.grey, offset: Offset(0, 3), blurRadius: 2)]),
              child: CustomText(
                color: blueFont,
                text: nom_du_menu,
                size: 20,
                weight: FontWeight.bold,

              ),
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xb7073662),
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                _showDialog();
              },
              icon: Icon(Icons.edit),
              label: Text("Modifier"),
            ),
          ],
        ),

        SizedBox(height: defaultPadding),
        Responsive(
          Mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 1 : 3,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 2.3 : 2,
          ),
          Tablet: FileInfoCardGridView(
            childAspectRatio:
            _size.width <= 850 && _size.width > 650 ? 1.8 : 1.8,
          ),
          Desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 2.8 : 2,
          ),
        ),
      ],
    );
  }
}
//*******************************************************
class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final Map info;

  showMenu(context,img, title, desc, quantite, prix) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Stack(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                    height: Responsive.isMobile(context) ?
                    MediaQuery.of(context).size.height * 0.6
                        :
                    MediaQuery.of(context).size.height * 0.7,

                    width: Responsive.isMobile(context) ?
                    MediaQuery.of(context).size.width * 0.9
                        :
                    MediaQuery.of(context).size.width * 0.5,

                    margin: EdgeInsets.only(top: 6.h),
                    decoration: BoxDecoration(
                      color: white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10,
                          offset: Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child:  Padding(
                      padding: EdgeInsets.only(top: 35.h,left: 1.h,right: 1.h,bottom: 1.h),
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: black,
                              fontSize: 3.h,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            desc,
                            style: TextStyle(
                              color: black,
                            ),),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                quantite,
                                style: TextStyle(
                                  color: Colors.green,
                                ),),
                              Text(
                                prix,
                                style: TextStyle(
                                  color: Colors.red,
                                ),),
                            ],
                          )
                        ],
                      ),
                    )
                ),
                Positioned(
                  top: 0,
                  left: 16,
                  right: 16,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      children: [
                        OnHoverText(
                          child: Ink.image(
                            image: NetworkImage(img),
                            height: 40.h,
                            width: 100.w,
                            fit: BoxFit.cover,),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var cardImage = 'https://source.unsplash.com/random/800x600?Food';
    Widget card1(){
      return Container(
        // color: red,
          child: ExpansionCard(
            initiallyExpanded: true,
            borderRadius: 20,
            background: OnHoverText(

              child: InkWell(
                onTap: (){
                  showMenu(context,
                   cardImage,
                    info["plat"]["nomPlat"],
                    info["plat"]["descriptionPlat"],
                    info["quantite"].toString(),
                    info["plat"]["prix"].toString(),
                  );
                },
                child: Image.network(
                  cardImage,
                  height: 300,
                  width: 700,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    info["plat"]["nomPlat"],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      color: white,
                    ),
                  ),
                ],
              ),
            ),
          )
      );
    }


    return card1();
  }
}


class PopUpSelect extends StatefulWidget {
  PopUpSelect({required this.list});
  final List list;

  @override
  _PopUpSelectState createState() => _PopUpSelectState();
}

class _PopUpSelectState extends State<PopUpSelect> {
  TextEditingController quantiteController = TextEditingController();
  bool isSelectionMode = false;
  Map<int, bool> selectedFlag = {};
  List selections = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GridView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isDesktop(context) ? 3 :
          Responsive.isTablet(context) ? 2 : 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: Responsive.isDesktop(context) ? 0.9 :
          Responsive.isTablet(context) ? 1.2 : 1.3,
        ),
        itemBuilder: (context, index) {
          var plat = PlatCard(info: widget.list[index], isEditing: true);
          laList.add(plat);
          return plat;
        },
      ),
    );
  }
}