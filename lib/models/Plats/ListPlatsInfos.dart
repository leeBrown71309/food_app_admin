import 'package:admin/app_colors.dart';
import 'package:admin/constants.dart';
import 'package:admin/my%20widgets/textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import 'ListPlats.dart';

class PlatCard extends StatefulWidget {
  bool selection = false;
  TextEditingController quantiteController = TextEditingController();
  final Map info;
  bool isEditing = false;
  PlatCard({required this.info,required this.isEditing});

  @override
  State<PlatCard> createState() => _PlatCardState();
}

class _PlatCardState extends State<PlatCard> {
  bool isSelectionMode = false;
  Map<int, bool> selectedFlag = {};
  List selections = [];
  var selectedColor = Colors.transparent;
  Widget entry = Text("");

  void select(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }

  var pop;
  Widget _buildSelectQuantite(bool isSelected, Map data) {
    if (isSelectionMode) {
      return isSelected
          ? padding("Enter la quantité", Icons.verified_user_outlined,
              Icons.drive_file_rename_outline, widget.quantiteController)
          : Text("");
    } else {
      return Text("");
    }
  }

  Widget _buildSelectIcon(bool isSelected, Map data) {
    if (isSelectionMode) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: Theme.of(context).primaryColor,
      );
    } else {
      return CircleAvatar(
        child: Text("jeton"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Map data = widget.info;

    pop == null ? pop = buildContainer(context) : pop = pop;
    return GestureDetector(
      onTap: () {
        setState(() {
          if(widget.isEditing){
            if (selectedColor == white) {
              selectedColor = Colors.transparent;
              widget.selection = false;
              entry = Text("");
              pop = buildContainer(context);
            } else {
              selectedColor = white;
              widget.selection = true;
              entry = padding(
                  "Entrer la quantité du plat",
                  Icons.verified_user_outlined,
                  Icons.drive_file_rename_outline,
                  widget.quantiteController);
              pop = buildContainer(context);
            }
          }else{
            //ici doit exister la pop up qui affiche les détails du plats dans la liste des plats
          }
        });
      },
      child: pop,
    );
  }
  Container buildContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              color: Colors.white24,
              child: FittedBox(
                fit: BoxFit.fill,
                child: CachedNetworkImage(
                  imageUrl: widget.info['image'],
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          color: Colors.orange, value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white24,
            child: Text(widget.info['nomPlat'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: SideMenuColor)),
          ),
          Container(
            color: Colors.white24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.info['prix']} FCFA",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: SideMenuColor),
                ), //plats prix //plats number
              ],
            ),
          ),
          entry,
        ],
      ),
    );
  }

}

/*
 Container buildContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              color: Colors.white24,
              child: FittedBox(
                fit: BoxFit.fill,
                child: CachedNetworkImage(
                  imageUrl: widget.info['image'],
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          color: Colors.orange, value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white24,
            child: Text(widget.info['nomPlat'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: SideMenuColor)),
          ),
          Container(
            color: Colors.white24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.info['prix']} FCFA",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: SideMenuColor),
                ), //plats prix //plats number
              ],
            ),
          ),
          entry,
        ],
      ),
    );
  }
 */
//-------------------------------------------------------------
/*
Card(
          clipBehavior: Clip.antiAlias,
          color: la_couleur,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Ink.image(
                    image: AssetImage(imgPath),
                    fit: BoxFit.cover,
                    height: 250,
                    child: InkWell(
                      onTap: () => goToPageMatiereS(bac),
                      splashColor: Colors.blue.withAlpha(30),
                    ),
                  ),
                  Positioned(
                      bottom: 16,
                      right: 16,
                      left: 16,
                      child: Text(
                        question,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                  const SizedBox(
                    width: 500,
                    height: 200,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 10).copyWith(
                  bottom: 10,
                ),
                child: Text(
                  description,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ],
          ),
        ),
 */