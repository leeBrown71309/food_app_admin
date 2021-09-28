import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../app_colors.dart';
import '../../../constants.dart';
import '../../../custom_text.dart';
import '../../../responsive.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final Map info;



  showMenu(context,img, title, desc, quantite, prix) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: EdgeInsets.only(top: 6.h),
                  decoration: BoxDecoration(
                    color: white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child:  Padding(
                    padding: EdgeInsets.only(top: 35.h,left: 1.h,right: 1.h,bottom: 1.h),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: black,
                            fontSize: 3.h,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          desc,
                        style: TextStyle(
                          color: black,
                        ),),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              quantite,
                              style: TextStyle(
                                color: Colors.green,
                              ),),
                            Text(
                              prix,
                              style: TextStyle(
                                color: Colors.red,
                              ),),
                          ],
                        )
                      ],
                    ),
                  )
                ),
                Positioned(
                    top: 0,
                    left: 16,
                    right: 16,
                    child: Card(
                    clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
                      child: Stack(
                        children: [
                          Ink.image(
                              image: NetworkImage(img),
                            height: 40.h,
                            width: 50.w,
                            fit: BoxFit.cover,)
                        ],
                      ),
                    ),
                )
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Stack(
        children: [
          Ink.image(
            image: NetworkImage(info["plat"]["image"]),
            height: 100.h,
            fit: BoxFit.cover,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showMenu(context,
                        info["plat"]["image"],
                        info["plat"]["nomPlat"],
                        info["plat"]["descriptionPlat"],
                        info["quantite"].toString(),
                        info["plat"]["prix"].toString(),
                    );
                  },
                  splashColor: Colors.white12,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 5.h,
            right: 4.w,
            left: 3.w,
            child: Text(
              info['plat']["nomPlat"],
              style: TextStyle(
                  color: white, fontSize: 25, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
