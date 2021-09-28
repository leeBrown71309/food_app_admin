import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/Plats/ListPlats.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';

import '../../../app_colors.dart';
import '../../../constants.dart';
import '../../../custom_text.dart';
import '../../../responsive.dart';

class EditPlatJour extends StatefulWidget {
  @override
  _EditPlatJourState createState() => _EditPlatJourState();
}

class _EditPlatJourState extends State<EditPlatJour> {
  @override
  Widget build(BuildContext context) => Scaffold(

    body: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled)=>[
        SliverAppBar(
          shadowColor: Colors.black54,
          backgroundColor: SideMenuColor1,
          elevation: 10.0,
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
      body: Column(
        children: [
          HeaderPageName(namePage: ' Liste des plats',),
          ListPlats(),
        ],
      )
    ),
  );
}
