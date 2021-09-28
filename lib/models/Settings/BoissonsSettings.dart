import 'package:admin/controllers/MenuController.dart';
import 'package:admin/my%20widgets/textfield.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import '../../apiGetPost.dart';
import '../../app_colors.dart';
import '../../constants.dart';
import '../../custom_text.dart';
import '../../responsive.dart';
import 'forms_functions.dart';

class Boissons extends StatefulWidget {
  const Boissons({Key? key}) : super(key: key);

  @override
  _BoissonsState createState() => _BoissonsState();
}

class _BoissonsState extends State<Boissons> {
  @override
  Widget build(BuildContext context) => Scaffold(

    body: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled)=>[
        SliverAppBar(
          backgroundColor: SideMenuColor1,
          floating: true,
          snap: true,
          title: CustomText(
            text: "Dashboard",
            size: 20,
            color: white,
            weight: FontWeight.bold,
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Row(
              children: [
                if (!Responsive.isDesktop(context))
                  IconButton(
                    icon: Icon(Icons.menu,color: white,),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            HeaderPageName(namePage: " Parametre > jus"),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 10.h,
                    backgroundImage: AssetImage("assets/gif/B.gif"),
                  ),
                  Icon(Icons.warning_amber_rounded,color: red,),
                  descjus,
                  Text(
                    'Enregistrement des jus',
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
                      child: BoissonForm(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ),
  );
}

class BoissonForm extends StatefulWidget {
  @override
  _BoissonFormState createState() => _BoissonFormState();
}

class _BoissonFormState extends State<BoissonForm> {
  var nomJus;
  var image;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nomJusController = TextEditingController();
  TextEditingController prixController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController prixBolController = TextEditingController();

  bool _bottle = false;
  bool _notBottle = false;
  var choix = [false,false];
  var les_prix = [0,0];

  Widget _isbottle() {
    return Container(
      height: 30.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black54),
            child: Checkbox(
              value: _bottle,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _bottle = value!;
                  choix[0] = _bottle;
                });
              },
            ),
          ),
          CustomText(
              text: "Bouteille !!!",
              size: 15,
              color: Colors.black54,
              weight: FontWeight.normal)
        ],
      ),
    );
  }

  Widget _isNotbottle() {
    return Container(
      height: 30.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black54),
            child: Checkbox(
              value: _notBottle,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _notBottle = value!;
                  choix[1] = _notBottle;
                });
              },
            ),
          ),
          CustomText(
              text: "En bol!!!",
              size: 15,
              color: Colors.black54,
              weight: FontWeight.normal)
        ],
      ),
    );
  }

  _insert() {
    var values = {
      'nomJus': nomJusController.text,
      'prix': prixController.text,
      'image': imageController.text,
      'choix': choix,
      'les_prix': les_prix,
    };
    var req = CallApiPost();
    req.postData(values, apiJus_post);
    setState(() {
      prixController.text = "";
      nomJusController.text = "";
      imageController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formkey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Nom du jus",
                // textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w700),),
            ],
          ),

          Container(
            decoration: BoxDecoration(
                color: Color(0xc241e675),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: TextFormField(
                controller: nomJusController,
                onChanged: (value) => setState(() => nomJus = value),
                validator: (value) =>
                value!.isEmpty ? "Entrer le nom du jus" : null,
                style: TextStyle(
                  color: black,
                ),
                decoration: inputDecorationFormNomjus,
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Prix de la boutteile",
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
                    color: Color(0xc241e675),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    controller: prixController,
                    onChanged: (value) => setState(() => les_prix[0] = int.parse(value)),
                    validator: (value) =>
                    value!.isEmpty ? "Donner le prix de la bouteille" : null,
                    style: TextStyle(
                      color: black,
                    ),
                    decoration: inputDecorationFormPrixJus,
                  ),
                ),
              ),
              _notBottle?Padding(
                padding: const EdgeInsets.only(left: 118.0,bottom: 30),
                child: Column(
                  children: [
                    Container(
                      child: Text("Prix du bol",
                        style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w700),),
                      margin: EdgeInsets.only(bottom: 30.0,left: 70),
                    ),
                    Container(
                      width: 20.w,
                      decoration: BoxDecoration(
                          color: Color(0xc241e675),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          controller: prixBolController,
                          onChanged: (value) => setState(() => les_prix[1] = int.parse(value)),
                          validator: (value) =>
                          value!.isEmpty ? "Donner le prix du bol" : null,
                          style: TextStyle(
                            color: black,
                          ),
                          decoration: inputDecorationFormPrixJus,
                        ),
                      ),
                    ),
                  ],
                ),
              ):Text(""),
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
                color: Color(0xc241e675),
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
                decoration: inputDecorationFormImgjus,
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Type du jus",
                // textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w700),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _isbottle(),
              _isNotbottle()
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
              color:  Color(0xc241e675),
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
    );
  }
}
