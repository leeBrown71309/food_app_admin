import 'package:allo_thieb/controllers/MenuController.dart';
import 'package:allo_thieb/help/apiGetPost.dart';
import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/constants.dart';
import 'package:allo_thieb/help/custom_text.dart';
import 'package:allo_thieb/screens/dashboard/components/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

import '../../responsive.dart';


class DefaultPlat extends StatefulWidget {
  const DefaultPlat({Key? key}) : super(key: key);

  @override
  _DefaultPlatState createState() => _DefaultPlatState();
}

class _DefaultPlatState extends State<DefaultPlat> {
  @override
  Widget build(BuildContext context) => Scaffold(

    body:  NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled)=>[
          SliverAppBar(
            shadowColor: Colors.blue,
            backgroundColor: white,
            elevation: 10.0,
            forceElevated: true,
            floating: true,
            snap: true,
            title: CustomText(
              text: "Dashboard",
              size: 20,
              color: SideMenuColor,
              weight: FontWeight.bold,
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Row(
                children: [
                  if (!Responsive.isDesktop(context))
                    IconButton(
                      icon: Icon(Icons.menu,color: SideMenuColor,),
                      onPressed: context.read<MenuController>().controlMenu,
                    ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Notifycation(),
                    ProfileCard(),

                  ],
                ),
              ),
            ],
          )
        ],
        body: Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              HeaderPageName(namePage: " Parametre > Plats"),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 10.h,
                      backgroundImage: AssetImage("assets/gif/platLogo.gif"),
                    ),
                    Icon(Icons.warning_amber_rounded,color: red,),
                    descPlat,
                    Text(
                      'Enregistrement des plats',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Container(
                      width: 55.w,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide( //                   <--- left side
                            color: Color(0xb7073662),
                            width: 0.5,
                          ),
                          right: BorderSide( //                    <--- top side
                            color: Color(0xb7073662),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: PlatForm(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
        )
    ),
  );
}

class PlatForm extends StatefulWidget {
  const PlatForm({Key? key}) : super(key: key);

  @override
  _PlatFormState createState() => _PlatFormState();
}

class _PlatFormState extends State<PlatForm> {
  var nomPlat;
  var description;
  bool couleurJetonBleu = false;
  bool couleurJetonRouge = false;
  bool couleurJetonNoir = false;
  var prix;
  var image;

  Map couleur_choisis = {"red":false,"blue":false,"black":false};
  var couleur = "white";
  final blue = Color(0xff0658b3);
  final red = Color(0xffbf0916);
  final noir = Color(0xff070707);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController nomPlatController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController jetonController = TextEditingController();
  TextEditingController prixController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  _insert() {
    var values = {
      'nomPlat': nomPlatController.text,
      'descriptionPlat': descriptionController.text,
      'jeton': couleur,
      'prix': prixController.text,
      'image': imageController.text,
    };
    var req = CallApiPost();
    req.postData(values, apiPlat_post);
    setState(() {
      nomPlatController.text = "";
      descriptionController.text = "";
      jetonController.text = "";
      prixController.text = "";
      imageController.text = "";
    });
  }

  Widget _buildCheckboxBleu( color,titre) {
    return Container(
      height: 30.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black54),
            child: Checkbox(
              value: couleurJetonBleu,
              checkColor: Colors.blueAccent,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  couleurJetonBleu = value!;
                  couleurJetonBleu?couleur = "blue":couleur = "white";
                  couleur_choisis['blue'] = value;
                  couleurJetonRouge = false;
                  couleurJetonNoir = false;

                });
              },
            ),
          ),
          Text(
            titre,
            style: TextStyle(color: Colors.black54),
          ),
          Icon(Icons.stop_circle_outlined,color: color,size: 30,)
        ],
      ),
    );
  }
  Widget _buildCheckboxRouge( color,titre) {
    return Container(
      height: 30.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black54),
            child: Checkbox(
              value: couleurJetonRouge,
              checkColor: Colors.red,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  couleurJetonRouge = value!;
                  couleurJetonBleu?couleur = "red":couleur = "white";
                  couleur_choisis['red'] = value;
                  couleurJetonBleu = false;
                  couleurJetonNoir = false;
                });
              },
            ),
          ),
          Text(
            titre,
            style: TextStyle(color: Colors.black54),
          ),
          Icon(Icons.stop_circle_outlined,color: color,size: 30,)
        ],
      ),
    );
  }
  Widget _buildCheckboxNoir( color,titre) {
    return Container(
      height: 30.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black54),
            child: Checkbox(
              value: couleurJetonNoir,
              checkColor: Colors.black,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  couleurJetonNoir = value!;
                  couleurJetonBleu?couleur = "black":couleur = "white";
                  couleur_choisis['black'] = value;
                  couleurJetonBleu = false;
                  couleurJetonRouge = false;
                  print(couleur_choisis.toString());
                });
              },
            ),
          ),
          Text(
            titre,
            style: TextStyle(color: Colors.black54),
          ),
          Icon(Icons.stop_circle_outlined,color: color,size: 30,)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Nom du Plat",
                // textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w700),),
              ],
            ),

            Container(
              decoration: BoxDecoration(
                  color: Color(0xb7073662),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  controller: nomPlatController,
                  onChanged: (value) => setState(() => nomPlat = value),
                  validator: (value) =>
                      value!.isEmpty ? "Entrer le nom du plat" : null,
                  style: TextStyle(
                    color: black,
                  ),
                  decoration: inputDecorationFormNomPlat,
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Description",
                  // textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w700),),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xb7073662),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  controller: descriptionController,
                  onChanged: (value) => setState(() => description = value),
                  validator: (value) =>
                      value!.isEmpty ? "Entrer une description" : null,
                  style: TextStyle(
                    color: black,
                  ),
                  // expands: true,
                  maxLines: 5,
                  decoration: inputDecorationFormDesc,
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Prix",
                  // textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w700),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 20.w,
                  decoration: BoxDecoration(
                      color: Color(0xb7073662),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      controller: prixController,
                      onChanged: (value) => setState(() => prix = value),
                      validator: (value) =>
                          value!.isEmpty ? "Donner un prix" : null,
                      style: TextStyle(
                        color: black,
                      ),
                      decoration: inputDecorationFormPrix,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Photo",
                  // textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w700),),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xb7073662),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  controller: imageController,
                  onChanged: (value) => setState(() => image = value),
                  validator: (value) =>
                      value!.isEmpty ? "Mettez une image" : null,
                  style: TextStyle(
                    color: black,
                  ),
                  decoration: inputDecorationFormImg,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Couleur du jeton",
                  // textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w700),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCheckboxBleu(blue,"Blue"),
                _buildCheckboxRouge(red,"Rouge"),
                _buildCheckboxNoir(noir,"Noir")
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              width: 20.h,
              child: RaisedButton(
                elevation: 5.0,
                //si le champ email n'est pas correcte le boutton est invalide sinn...
                onPressed: () {
                  if(_formkey.currentState!.validate()){
                    _insert();
                  }
                },
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color:  Color(0xFF527DAA),
                child: Text(
                  'Valider',
                  style: TextStyle(
                    color: white,
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------


