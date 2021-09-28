import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:admin/my%20widgets/jus_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';
import '../../constants.dart';
import '../../custom_text.dart';
import '../../responsive.dart';
// import 'ListPlatsInfos.dart';

class ListJus extends StatefulWidget {
  const ListJus({Key? key}) : super(key: key);

  @override
  _ListJusState createState() => _ListJusState();
}

class _ListJusState extends State<ListJus> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: "Liste des Jus",
                size: 30,
                color: orange,
                weight: FontWeight.bold),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: ListJusCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: ListJusCardGridView(
            crossAxisCount: _size.width < 850 && _size.width > 1100 ? 3 : 4,
          ),
          desktop: ListJusCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class ListJusCardGridView extends StatefulWidget {
  const ListJusCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<ListJusCardGridView> createState() => _ListPlatCardGridView();
}

class _ListPlatCardGridView extends State<ListJusCardGridView> {
  var list = [];
  bool vf = true;

  Future getData() async {
    final http.Response response = await http.get(Uri.parse(apiJus_get));
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

  Widget ListJusbuildGridView() {
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
                itemBuilder: (context, index) => JusCard(info: list[index]),
              );
  }

  @override
  Widget build(BuildContext context) {
    return ListJusbuildGridView();
  }
}
