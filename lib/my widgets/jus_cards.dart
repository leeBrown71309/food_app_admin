import 'package:admin/my%20widgets/platMenuNumber.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class JusCard extends StatelessWidget {
  const JusCard({required this.info});
  final Map info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: CardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: FittedBox(
                fit: BoxFit.fill,
                child: CachedNetworkImage(
                  imageUrl: info['image'],
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          color: Colors.redAccent, value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(info['nomJus'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: SideMenuColor)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "500 FCFA",
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: SideMenuColor),
              ), //plats prix//plats number
            ],
          )
        ],
      ),
    );
  }
}

