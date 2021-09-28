import 'package:admin/models/Plats/ListPlatsInfos.dart';
import 'package:admin/my%20widgets/textfield.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/main_page.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../apiGetPost.dart';
import '../constants.dart';

class PopUpSelect extends StatefulWidget {
  PopUpSelect({required this.list, required this.libelle});
  final List list;
  final TextEditingController libelle;

  @override
  _PopUpSelectState createState() => _PopUpSelectState();

}

class _PopUpSelectState extends State<PopUpSelect> {
  TextEditingController quantiteController = TextEditingController();
  bool isSelectionMode = false;
  Map<int, bool> selectedFlag = {};
  List selections = [];

  _insert(List data, String libelle) {
    var values = {
      'listPlats': data,
      'libelle': libelle,
    };
    var req = CallApiPost();
    req.postData(values, apiMenuDuJour_post);
  }




  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    List laList = [];
    Widget ValidateMenu(){
      return ElevatedButton(
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
            _insert(data, widget.libelle.text);
            Navigator.of(context).pop();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        buildMaterialApp(context, MainScreen())));
          },
          child: Container(
            color: Colors.black,
            child: Text("Ok"),
          ));
    }

    return Column(
      children: [
        Padding(
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
                var plat = PlatCard(info: widget.list[index],isEditing: true);
                laList.add(plat);
                return plat;
              },
            ),
        ),
        //ValidateMenu()
      ],
    );
  }


}



/*

Card(
          clipBehavior: Clip.antiAlias,
          color: la_couleur,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Ink.image(
                    image: AssetImage(imgPath),
                    fit: BoxFit.cover,
                    height: 250,
                    child: InkWell(
                      onTap: () => goToPageMatiereS(bac),
                      splashColor: Colors.blue.withAlpha(30),
                    ),
                  ),
                  Positioned(
                      bottom: 16,
                      right: 16,
                      left: 16,
                      child: Text(
                        question,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                  const SizedBox(
                    width: 500,
                    height: 200,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 10).copyWith(
                  bottom: 10,
                ),
                child: Text(
                  description,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ],
          ),
        ),

 */