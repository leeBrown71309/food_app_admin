// import 'package:allo_thieb/help/app_colors.dart';
// import 'package:allo_thieb/help/onHoverbutton.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:focused_menu/focused_menu.dart';
// import 'package:focused_menu/modals.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../responsive.dart';
// import '../../textfield.dart';
// import 'ListPlats.dart';
//
// class PlatCard extends StatefulWidget {
//   bool selection = false;
//   TextEditingController quantiteController = TextEditingController();
//   final Map info;
//   bool isEditing = false;
//   PlatCard({required this.info,required this.isEditing});
//
//   @override
//   State<PlatCard> createState() => _PlatCardState();
// }
//
// class _PlatCardState extends State<PlatCard> {
//   bool isSelectionMode = false;
//   Map<int, bool> selectedFlag = {};
//   List selections = [];
//   var selectedColor = Colors.transparent;
//   Widget entry = Text("");
//   var cardImage = 'https://source.unsplash.com/random/800x600?Food';
//
//   void select(bool isSelected, int index) {
//     setState(() {
//       selectedFlag[index] = !isSelected;
//       isSelectionMode = selectedFlag.containsValue(true);
//     });
//   }
//
//   var pop;
//   Widget _buildSelectQuantite(bool isSelected, Map data) {
//     if (isSelectionMode) {
//       return isSelected
//           ? padding("Enter la quantité", Icons.verified_user_outlined,
//               Icons.drive_file_rename_outline, widget.quantiteController)
//           : Text("");
//     } else {
//       return Text("");
//     }
//   }
//
//   Widget _buildSelectIcon(bool isSelected, Map data) {
//     if (isSelectionMode) {
//       return Icon(
//         isSelected ? Icons.check_box : Icons.check_box_outline_blank,
//         color: Theme.of(context).primaryColor,
//       );
//     } else {
//       return CircleAvatar(
//         child: Text("jeton"),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Map data = widget.info;
//
//     pop == null ? pop = buildContainer(context) : pop = pop;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           if(widget.isEditing){
//             if (selectedColor == white) {
//               selectedColor = Colors.transparent;
//               widget.selection = false;
//               entry = Text("");
//               pop = buildContainer(context);
//             } else {
//               selectedColor = white;
//               widget.selection = true;
//               entry = padding(
//                   "Entrer la quantité du plat",
//                   Icons.verified_user_outlined,
//                   Icons.drive_file_rename_outline,
//                   widget.quantiteController);
//               pop = buildContainer(context);
//             }
//           }else{
//             //ici doit exister la pop up qui affiche les détails du plats dans la liste des plats
//           }
//         });
//       },
//       child: pop,
//     );
//   }
//   /*
//   Widget buildContainer(BuildContext context) {
//
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20)
//       ),
//       child: OnHoverCard(
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10)
//             ),
//               clipBehavior: Clip.antiAlias,
//               elevation: 3.0,
//               shadowColor: Color(0x8811b1e7),
//               child: Column(
//                 mainAxisSize:MainAxisSize.min,
//                 children: [
//                   Container(
//                     height: 20.h,
//                     child: Stack(
//
//                       children: [
//                         Ink.image(
//                           //image plat
//                           image:  NetworkImage(cardImage),
//                           fit: BoxFit.cover,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(top: 10,left: 16,right: 16,),
//                     alignment: Alignment.center,
//                     child: Column(
//                       mainAxisSize:MainAxisSize.min,
//                       children: [
//                         Text(widget.info['nomPlat'],
//                           style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
//                           overflow: TextOverflow.ellipsis,),
//                       ],
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             Text("Prix : ${widget.info['prix']} FCFA",),
//                            //essaie de faire en sorte qu'on puisse afficher aussi la quantité
//                           ],
//                         ),
//                       )),
//                 ],
//               )),
//         ),
//     );
//   }
//   /*
// }
//
//
// //-------------------------------------------------------------
