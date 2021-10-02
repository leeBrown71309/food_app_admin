import 'package:allo_thieb/controllers/MenuController.dart';
import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../responsive.dart';
import 'components/commande_recente.dart';
import 'components/header.dart';
import 'components/my_fields.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(defaultPadding1),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          MyFiles(),
                          SizedBox(height: 16),
                          DataPage(),
                          if (Responsive.isMobile(context))
                            SizedBox(height: defaultPadding),
                          if (Responsive.isMobile(context)) StarageDetails(),
                        ],
                      ),
                    ),
                    if (!Responsive.isMobile(context))
                      SizedBox(width: defaultPadding),
                    // On Mobile means if the screen is less than 850 we dont want to show it
                    if (!Responsive.isMobile(context))
                      Expanded(
                        flex: 2,
                        child: StarageDetails(),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    ),
  );
}

/*
* SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding1),
        child: Column(
          children: [
            Header(),
            // HeaderPageName(namePage: 'Dashboard',),
            SizedBox(height: 16,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: 16),
                      RecentFiles(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StarageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
* */