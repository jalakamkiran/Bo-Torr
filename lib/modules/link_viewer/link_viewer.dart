import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/app_colors.dart';
import 'package:libgen/app_theme.dart';

import 'link_viewer_logic.dart';

class LinkViewer extends StatefulWidget {
  LinkViewer({Key? key}) : super(key: key);

  @override
  State<LinkViewer> createState() => _LinkViewerState();
}

class _LinkViewerState extends State<LinkViewer> {
  final logic = Get.find<LinkViewerLogic>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.appGradient,
        ),
        child: Column(
          children: List.generate(logic.downloadUrls.length, (index) {
            return _linkCard(index);
          }),
        ),
      ),
    );
  }

  Flexible _linkCard(int index) {
    return Flexible(
      child: InkWell(
        onTap: (){
          logic.onLinkTapped(logic.downloadUrls[index]);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: inActiveBottomBarColor,
              width: 1,
            ),
          ),
          child: ClipRRect(
            child: Banner(
              location: BannerLocation.topEnd,
              message: logic.downloadUrls[index].toString().contains("libgen.rs")
                  ? 'Ads'
                  : "Direct",
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  logic.downloadUrls[index],
                  maxLines: 2,
                  style: const TextStyle(
                      color: primaryTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
