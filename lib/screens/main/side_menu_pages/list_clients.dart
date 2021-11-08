
import 'package:allo_thieb/controllers/MenuController.dart';
import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/custom_text.dart';
import 'package:allo_thieb/help/onHoverbutton.dart';
import 'package:allo_thieb/models/clients.dart';
import 'package:allo_thieb/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../responsive.dart';

class ListClient extends StatefulWidget {
  const ListClient({Key? key}) : super(key: key);

  @override
  _ListClientState createState() => _ListClientState();
}

class _ListClientState extends State<ListClient> {
  @override
  Widget build(BuildContext context) => Scaffold(

    body: NestedScrollView(
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
          leading: Row(
              children: [
                if (!Responsive.isDesktop(context))
                  IconButton(
                    icon: Icon(Icons.menu,color: SideMenuColor,),
                    onPressed: context.read<MenuController>().controlMenu,
                  ),
              ],
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
          child:  Column(
            children: [
              SizedBox(height: 10,),
              HeaderPageName(namePage: ' Liste des Clients',),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Banner(),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Container(
                    padding: EdgeInsets.all(7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Clients enregistrés",
                          size: 20,
                          color: black,
                        ),
                        Clients(),
                        SizedBox(height: 20,),
                        // Footer()
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class Banner extends StatelessWidget {

  var cardImage = 'https://source.unsplash.com/random/800x600?Person';
  @override
  Widget build(BuildContext context) {
    Widget buildCard() => GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.blueAccent.withOpacity(0.2),
              child: Image.network(cardImage, fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
    Widget banner(){
      return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: LinearGradient(colors: [
              Color(0xf3f4761c),
              Color(0xfe840eec),
              Color(0xf6f51445)
            ])),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    OnHoverText(
                      child: Image.asset(
                        'images/jusbg.png',
                        width: 15.w,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Bienvenue dans la liste des boissons",
                      style: TextStyle(
                          color: white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),),
                    Text("Vous retrouverez ici la liste de toutes les boissons",
                      style: TextStyle(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal
                      ),)
                  ],
                ),
              ],
            ),

          ],
        ),
      );
    }
    return banner();
  }
}