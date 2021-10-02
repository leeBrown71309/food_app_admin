import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/custom_text.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../responsive.dart';



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
          color: white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: SideMenuColor),
        ),
        child: Row(
          children: [
            // TextAvatar(
            //   shape: Shape.Circular,
            //   size: 35,
            //   textColor: Colors.white,
            //   fontSize: 14,
            //   fontWeight: FontWeight.w600,
            //   upperCase: true,
            //   backgroundColor: Colors.black,
            //   numberLetters: 1,
            //   text: "Angelina Jolie",
            // ),

            Image.asset(
              "assets/images/profile_pic.png",
              height: 38,
            ),
            if (!Responsive.isMobile(context))
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text("Angelina Jolie",
                style: TextStyle(color: SideMenuColor),),
              ),
            Icon(Icons.keyboard_arrow_down,color: SideMenuColor,),
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
         TextButton.icon(
             onPressed: (){},
             icon:  Stack(
               children: [
                 Icon(Icons.notifications_active,
                       color: black,size: 25,),
                 Positioned(
                   top: -1,
                   left: 11,
                   child: Container(
                     width: 12,
                     height: 12,
                     decoration: BoxDecoration(
                         color: Colors.red,
                         borderRadius: BorderRadius.circular(20)
                     ),
                   ),
                 ),

               ],
             ),
             label: Responsive.isDesktop(context) ?
             CustomText(
               text: 'Notification', size: 16, color: black,
             ) : Text("")
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
