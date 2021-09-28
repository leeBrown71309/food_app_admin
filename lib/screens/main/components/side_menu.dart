import 'package:admin/app_colors.dart';
import 'package:admin/custom_text.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/side_menu_pages/boissons.dart';
import 'package:admin/screens/main/side_menu_pages/commande.dart';
import 'package:admin/screens/main/side_menu_pages/edit_plat_jour.dart';
import 'package:admin/screens/main/side_menu_pages/facturation.dart';
import 'package:admin/screens/main/side_menu_pages/historique.dart';
import 'package:admin/screens/main/side_menu_pages/list_clients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/*
class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Icon(Icons.food_bank_rounded,size: 50,),
                CustomText(
                    text: "Allo Thieb",
                    size: 15,
                    color: white)
              ],
            ),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              setState(() => screen = DashboardScreen());
            },
          ),
          Divider(color: Colors.white24,),
          DrawerListTile(
            title: "Gestion des plats du jours",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              setState(() => screen = EditPlatJour());
            },
          ),
          Divider(color: Colors.white24,),
          DrawerListTile(
            title: "Gestion des boissons",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              setState(() => screen = GestionBoissons());
            },
          ),
          Divider(color: Colors.white24,),
          DrawerListTile(
            title: "Clients",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              setState(() => screen = ListClient());
            },
          ),
          Divider(color: Colors.white24,),
          DrawerListTile(
            title: "Commandes",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              setState(() => screen = ListCommande());
            },
          ),
          Divider(color: Colors.white24,),
          DrawerListTile(
            title: "Facturation",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              setState(() => screen = ListFacture());
            },
          ),
          Divider(color: Colors.white24,),
          DrawerListTile(
            title: "Historique",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              setState(() => screen = Historique());
            },
          ),
          Divider(color: Colors.white24,),
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
                  // setState(() => screen = DefaultPlat());
                },
              ),
              DrawerListTile(
                title: "Ajouter une boisson",
                svgSrc: "assets/icons/menu_profile.svg",
                press: () {
                  // setState(() => screen = Boissons());
                },
              ),
            ],

          )
        ],
      ),
    );
  }
}
*/

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
