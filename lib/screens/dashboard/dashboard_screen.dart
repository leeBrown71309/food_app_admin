import 'package:admin/app_colors.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/main/components/page_header.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../custom_text.dart';
import 'components/header.dart';

import 'components/recent_files.dart';

import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
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
      body: SafeArea(
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