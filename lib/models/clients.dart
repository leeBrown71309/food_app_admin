import 'dart:convert';
import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/loading.dart';
import 'package:allo_thieb/help/onHoverbutton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:allo_thieb/help/constants.dart';
import 'package:flutter/material.dart';

import '../responsive.dart';


class Clients extends StatefulWidget {
  Clients({Key? key}) : super(key: key);

  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: defaultPadding),
        Responsive(
          Mobile: UserGridView(
            crossAxisCount: _size.width < 850 ? 2 : 4,
            childAspectRatio: _size.width < 850 && _size.width > 350 ? 0.8 : 1,
          ),
          Tablet: UserGridView(
            crossAxisCount: _size.width < 1100 ? 3 : 4,
            childAspectRatio: _size.width < 1100 && _size.width > 850 ? 0.9 : 0.9,
          ),
          Desktop: UserGridView(
            childAspectRatio: _size.width < 1400 && _size.width > 1100 ? 1 : 1,
          ),
        ),
      ],
    );
  }
}
//*********************************************************

class UserGridView extends StatefulWidget {
  UserGridView({this.crossAxisCount = 4,this.childAspectRatio = 1,});
  final int crossAxisCount;
  final double childAspectRatio;

  @override
  _UserGridViewState createState() => _UserGridViewState();
}

class _UserGridViewState extends State<UserGridView> {
  var list = [];
  bool vf = true;
  var cardImage = 'https://source.unsplash.com/random/800x600?Person';
  bool isAnimated = false;
  Future getData() async {
    final http.Response response = await http.get(Uri.parse(apiUserInfo));
    if (response.statusCode == 200) {
      setState(() {
        vf = false;
      });
      list = jsonDecode(response.body);
    } else {
      list = ["R.A.S"];
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget ListCientsBuildGridView() {
    return vf
        ? Center(child: Loading())
        : list[0] == "R.A.S"
        ? Container(
      child: Center(
        child: Text(
          "CONNEXION A LA BASE DE DONNEE ECHOUEE!",
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: orange),
        ),
      ),
    )
        : GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        height: 400,
        width: 330.0,
        child: Responsive.isDesktop(context)?
        Stack(
          children: [
            Align(
              alignment: Alignment(0, 0),
              child: Container(
                height: 400.0,
                width: 330.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey.withOpacity(0.2)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        list[index]['nom'],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0,-1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0,1),
              child: AnimatedOpacity(opacity: isAnimated ? 1 : 0,
                duration: Duration(milliseconds: 180),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    list[index]['nom'],
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0
                    ),
                  ),
                ),
              ),
            ),
            MouseRegion(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  height: 430,
                  width:  370,
                  child: OnHoverUserCard(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      height: 430,
                      width:  370,
                      child: Image(
                        image: NetworkImage(cardImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            )

          ],
        )
            :
        Stack(
              children: [
                Align(
                  alignment: Alignment(0, 0),
                  child: Container(
                    height: 400.0,
                    width: 330.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.grey.withOpacity(0.2)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0,-1),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0,1),
                  child: AnimatedOpacity(opacity: isAnimated ? 1 : 0,
                    duration: Duration(milliseconds: 180),
                    child: Container(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                        list[index]['nom'],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      height: 430,
                      width:  370,
                      child: OnHoverUserCard(
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          height: 430,
                          width:  370,
                          child: Image(
                            image: NetworkImage(cardImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      Text(
                        list[index]['nom'],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListCientsBuildGridView();
  }
}

