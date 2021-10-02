import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/onHoverbutton.dart';
import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';


class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    Key? key,
    required this.nom,
    required this.icon,
  }) : super(key: key);

  final String nom;
  final IconData icon;

  Widget AvatarPick (){
    return AdvancedAvatar(
      name: 'User Name',
      statusColor: Colors.green,
      statusAngle: 30,
      size: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnHoverText(
      child: Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.all(5),
        child: InkWell(
          onTap: (){},
          // hoverColor: Color(0x2efb3e5a),
          // splashColor: white,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Row(
                 children: [
                   AvatarPick(),
                   SizedBox(width: 10,),
                   Text(nom,
                     overflow: TextOverflow.ellipsis,
                     style: TextStyle(fontSize: 15),
                   ),
                 ],
               ),
                Icon(Icons.arrow_forward_ios_outlined,size: 20,)
              ],
            ),
          ),
        )
      ),
    );
  }
}

/*
Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nom,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20
                    ),
                  ),
                ],
              ),
 */