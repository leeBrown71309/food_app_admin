import 'dart:convert';
import 'package:admin/models/Plats/ListPlatsInfos.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import '../../../apiGetPost.dart';
import '../../../constants.dart';
import '../../../custom_text.dart';
import '../../../loading.dart';
import '../dashboard_screen.dart';
import 'file_info_card.dart';

var nom_du_menu = "Menu du jour : ";
List laList = [];

void insert(List data, String libelle) {
  var values = {
    'listPlats': data,
    'libelle': libelle,
  };
  var req = CallApiPost();
  req.postData(values, apiMenuDuJour_post);
}

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

  Widget buildGridView() {
    return verify
        ? Loading()
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
            itemBuilder: (context, index) => FileInfoCard(info: list[index]),
          );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return buildGridView();
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
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 3),
                        blurRadius: 24)
                  ]),
              height: (_size.height * 80) / 100,
              width: (_size.width * 80) / 100,
              child: vf ? Center(child: Loading()) : PopUpSelect(list: list1),
            ),
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
                        insert(data, libelleController.text);
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
            CustomText(
              color: blueFont,
              text: nom_du_menu,
              size: 20,
              weight: FontWeight.bold,
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
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 1 : 3,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1 : 1.4,
          ),
          tablet: FileInfoCardGridView(
            childAspectRatio: _size.height < 400 ? 1.4 : 1,
          ),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
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
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
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
