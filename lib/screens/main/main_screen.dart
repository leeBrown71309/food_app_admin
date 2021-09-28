import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/Settings/BoissonsSettings.dart';
import 'package:admin/models/Settings/PlatSettings.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/side_menu_pages/boissons.dart';
import 'package:admin/screens/main/side_menu_pages/commande.dart';
import 'package:admin/screens/main/side_menu_pages/edit_plat_jour.dart';
import 'package:admin/screens/main/side_menu_pages/facturation.dart';
import 'package:admin/screens/main/side_menu_pages/historique.dart';
import 'package:admin/screens/main/side_menu_pages/list_clients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../app_colors.dart';
import '../../custom_text.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget screen = DashboardScreen();
  Drawer sideMenu() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/allothieb.jpeg")
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              setState(() => screen = DashboardScreen());
            },
          ),

          DrawerListTile(
            title: "Gestion des plats du jours",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              setState(() => screen = EditPlatJour());
            },
          ),

          DrawerListTile(
            title: "Gestion des boissons",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              setState(() => screen = GestionBoissons());
            },
          ),

          DrawerListTile(
            title: "Clients",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              setState(() => screen = ListClient());
            },
          ),

          DrawerListTile(
            title: "Commandes",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              setState(() => screen = ListCommande());
            },
          ),

          DrawerListTile(
            title: "Facturation",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              setState(() => screen = ListFacture());
            },
          ),

          DrawerListTile(
            title: "Historique",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              setState(() => screen = Historique());
            },
          ),

          ExpansionTile(
            leading: SvgPicture.asset(
              "assets/icons/menu_notification.svg",
              color: Colors.white,
              height: 16,
            ),
            title: CustomText(
              color: white,
              text: 'Parametres',
              weight: FontWeight.normal,
              size: 15,
            ),
            children: [
              DrawerListTile(
                title: "Ajouter un plat",
                svgSrc: "assets/icons/menu_profile.svg",
                press: () {
                  setState(() => screen = DefaultPlat());
                },
              ),
              DrawerListTile(
                title: "Ajouter une boisson",
                svgSrc: "assets/icons/menu_profile.svg",
                press: () {
                  setState(() => screen = Boissons());
                },
              ),
            ],

          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: sideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: sideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: screen,
            ),
          ],
        ),
      ),
    );
  }
}
