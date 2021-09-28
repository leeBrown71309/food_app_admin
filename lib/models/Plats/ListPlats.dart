import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../app_colors.dart';
import '../../constants.dart';
import '../../custom_text.dart';
import '../../responsive.dart';
import 'ListPlatsInfos.dart';

class ListPlats extends StatefulWidget {
  const ListPlats({Key? key}) : super(key: key);

  @override
  _ListPlatsState createState() => _ListPlatsState();
}

class _ListPlatsState extends State<ListPlats> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: "Liste des plats",
                size: 30,
                color: Colors.orange,
                weight: FontWeight.bold),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: ListPlatCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: ListPlatCardGridView(
            crossAxisCount: _size.width < 850 && _size.width > 1100 ? 3 : 4,
          ),
          desktop: ListPlatCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class ListPlatCardGridView extends StatefulWidget {
  const ListPlatCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<ListPlatCardGridView> createState() => _ListPlatCardGridView();
}

class _ListPlatCardGridView extends State<ListPlatCardGridView> {
  var list = [];
  bool vf = true;

  Future getData() async {
    final http.Response response = await http.get(Uri.parse(apiPlat_get));
    if (response.statusCode == 200) {
      setState(() {
        vf = false;
      });
      list = jsonDecode(response.body);
    } else {
      list = ["R.A.S"];
    }
  }

  Widget ListPlatbuildGridView() {
    return vf
        ? Center(child: CircularProgressIndicator())
        : list[0] == "R.A.S"
            ? Container(
                child: Center(
                  child: Text(
                    "CONNEXION A LA BASE DE DONNEE ECHOUEE!",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
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
                itemBuilder: (context, index) => PlatCard(info: list[index],isEditing: false),
              );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListPlatbuildGridView();
  }
}
