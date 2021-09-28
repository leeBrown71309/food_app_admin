import 'dart:ui';

import 'package:admin/custom_text.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);

const defaultPadding = 16.0;
const primaryColorO = Color(0xFFf64f11);
const secondaryColorR = Color(0xFFb60036);
const SideMenuColor = Color(0xFFb60036);
const SideMenuColor1 = Color(0xdfea2424);
const bgColor1 = Color(0xd7ffffff);
const CardColor = Color(0xffffffff);
const blueFont = Color(0xFF2A2D3E);
const blueFont2 = Color(0xFF212332);
const defaultPadding1 = 10.0;
const image = "assets/images/img1.jpg";
const orange = Colors.orange;


//api links
//api links
String host = "https://alothiep-food-app.herokuapp.com/";
String apiCommandeRecente = host +"api/Commande/recente";
String apiUserInfo = "http://localhost:8000/api/User";
String apiMenuDuJour_get = host + "api/Menu/menu_du_jour";
// String apiMenuDuJour_get = "http://localhost:8000/api/Menu/menu_du_jour";
String apiMenuDuJour_post = host + "api/PlatMenu/menu_du_jour";
// String apiMenuDuJour_post = "http://localhost:8000/api/PlatMenu/menu_du_jour";

String apiPlat_post = host + "api/Plats";
String apiPlat_get = host + "api/Plats";
// String apiPlat_get = "http://localhost:8000/api/Plats";
// String apiJus_post = host + "api/Jus";
String apiJus_post = "http://localhost:8000/api/Jus";
String apiJus_get = "http://localhost:8000/api/Jus";
// String apiJus_get = host + "api/Jus";
String apiUsers = "http://localhost:8000/api/User";
String apiCommandes = "http://localhost:8000/api/Commande";

//---------------------------------------------------------
//**decoration du formulaire des plats
//---------------------------------------------------------

const inputDecorationFormNomPlat =  InputDecoration(
  label: Text('Nom du plat'),
  floatingLabelStyle: TextStyle(color: white,
      fontSize: 20),
  border: InputBorder.none,
  hintText: 'EX: Yassa poulet',
  hintStyle: TextStyle(color: Colors.white54),
  prefixIcon: Icon(Icons.edit,color: white,),
  suffixIcon: Icon(Icons.edit_attributes_outlined,color: white,size: 30,),
);
const inputDecorationFormDesc =  InputDecoration(
  label: Text('Description'),
  floatingLabelStyle: TextStyle(color: white,
      fontSize: 20),
  border: InputBorder.none,
  hintText: 'EX: Le Yassa est ...',
  hintStyle: TextStyle(color: Colors.white54),
  prefixIcon: Icon(Icons.description,color: white,),
  suffixIcon: Icon(Icons.edit_attributes_outlined,color: white,size: 30,),
);
const inputDecorationFormPrix =  InputDecoration(
  label: Text('Prix'),
  floatingLabelStyle: TextStyle(color: white,
      fontSize: 20),
  border: InputBorder.none,
  hintText: 'EX: 2000',
  hintStyle: TextStyle(color: Colors.white54),
  prefixIcon: Icon(Icons.monetization_on_outlined,color: white,),
  suffixText: "FCFA",
  suffixStyle: TextStyle(color: white,),
);
const inputDecorationFormImg =  InputDecoration(
  label: Text('Image'),
  floatingLabelStyle: TextStyle(color: white,
      fontSize: 20),
  border: InputBorder.none,
  hintText: 'EX: image.png',
  hintStyle: TextStyle(color: Colors.white54),
  prefixIcon: Icon(Icons.image_outlined,color: white,),
  suffixIcon: Icon(Icons.edit_attributes_outlined,color: white,size: 30,),
);

//---------------------------------------------------------
//**decoration du formulaire des jus
//---------------------------------------------------------
const inputDecorationFormNomjus =  InputDecoration(
  label: Text('Nom du jus'),
  floatingLabelStyle: TextStyle(color: white,
      fontSize: 20),
  border: InputBorder.none,
  hintText: 'EX: Coca cola',
  hintStyle: TextStyle(color: Colors.white54),
  prefixIcon: Icon(Icons.edit,color: white,),
  suffixIcon: Icon(Icons.edit_attributes_outlined,color: white,size: 30,),
);
const inputDecorationFormPrixJus =  InputDecoration(
  label: Text('Prix'),
  floatingLabelStyle: TextStyle(color: white,
      fontSize: 20),
  border: InputBorder.none,
  hintText: 'EX: 500',
  hintStyle: TextStyle(color: Colors.white54),
  prefixIcon: Icon(Icons.monetization_on_outlined,color: white,),
  suffixIcon: Icon(Icons.edit_attributes_outlined,color: white,size: 30,),
);
const inputDecorationFormImgjus =  InputDecoration(
  label: Text('Image'),
  floatingLabelStyle: TextStyle(color: white,
      fontSize: 20),
  border: InputBorder.none,
  hintText: 'EX: image.png',
  hintStyle: TextStyle(color: Colors.white54),
  prefixIcon: Icon(Icons.image_outlined,color: white,),
  suffixIcon: Icon(Icons.edit_attributes_outlined,color: white,size: 30,),
);

final descPlat =  CustomText(
    text: "Enregistrer les differents plats qui existe au seins "
        "de votre restaurant.\n"
        "NB: Veuillez remplir tous les champs au risque d'avoir une erreur.",
    size: 15,
    color: Colors.black54);
final descjus =  CustomText(
    text: "Enregistrer les differents jus qui existe au seins "
        "de votre restaurant.\n"
        "NB: Veuillez remplir tous les champs au risque d'avoir une erreur.",
    size: 15,
    color: Colors.black54);
String titleInfo = "Cliquer sur l'image pour plus d'informations sur le plat";

const inputDecorationNomMenu =  InputDecoration(
  label: Text('Menu'),
  floatingLabelStyle: TextStyle(color: black,
      fontSize: 20),
  border: InputBorder.none,
  hintText: 'EX: Menu frittes',
  hintStyle: TextStyle(color: Colors.white54),
  prefixIcon: Icon(Icons.menu_book_rounded,color: white,),
  suffixIcon: Icon(Icons.edit_attributes_outlined,color: white,size: 30,),
);