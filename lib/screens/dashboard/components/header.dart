import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../app_colors.dart';
import '../../../constants.dart';
import '../../../custom_text.dart';


class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("moiiiii");},
      child: Container(
        margin: EdgeInsets.only(left: defaultPadding),
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: SideMenuColor1,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: white),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/profile_pic.png",
              height: 38,
            ),
            if (!Responsive.isMobile(context))
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text("Angelina Jolie"),
              ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}

class Notifycation extends StatelessWidget {
  const Notifycation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:   Row(
        children: [
          Stack(
            children: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.notifications_active,
                    color: white,size: 25,)),
              Positioned(
                top: 4,
                left: 9,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),

            ],
          ),
          if(Responsive.isDesktop(context))
            TextButton(
                onPressed: (){}, child: CustomText(
              text: 'Notification', size: 16, color: white,
            ),
               
            )

        ],
      ),
    );
  }
}

class HeaderPageName extends StatelessWidget {
  const HeaderPageName({required this.namePage});
  final String namePage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomText(
            text: ">"+ namePage, size: 2.h, color: Colors.black54,weight: FontWeight.bold,),
      ],
    );
  }
}
