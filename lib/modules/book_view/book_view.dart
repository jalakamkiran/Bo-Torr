import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/app_colors.dart';
import 'package:libgen/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:libgen/common_widgets/app_button.dart';
import 'package:libgen/res.dart';
import 'book_view_logic.dart';
import 'package:flutter/scheduler.dart';

class BookViewPage extends StatelessWidget {
  final logic = Get.find<BookViewLogic>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookViewLogic>(builder: (logic) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppTheme.appGradient,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _topWidget(),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _bookInfoItems(),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: AppButton(
                          onTap: logic.onReadNowTapped,
                          isLoading: logic.isLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Padding _bookInfoItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: _buildBookInfo("Pages", logic.book.pages)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildBookInfo("Rating", "-"),
              ),
            ),
            Expanded(child: _buildBookInfo("Reviews", "-")),
          ],
        ),
      ),
    );
  }

  Column _buildBookInfo(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 14,
              color: inActiveBottomBarColor,
              fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  Expanded _topWidget() {
    return Expanded(
      flex: 4,
      child: Container(
        width: double.infinity,
        decoration: _topWidgetDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _topBar(),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 6,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: logic.book,
                      child: CachedNetworkImage(
                        imageUrl: logic.book.coverurl,
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: Text(
                  logic.book.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: primaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Flexible(
                child: Text(
                  logic.book.author,
                  style: const TextStyle(
                      color: primaryTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _topWidgetDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
          colors: [Color(0xFF6C4025), Color(0xFF6C4725)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
    );
  }

  Row _topBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              Get.back();
            },
            child: _topBarIconBuilder(Res.back)),
        _topBarIconBuilder(Res.favoriteDisabled),
      ],
    );
  }

  Container _topBarIconBuilder(String icon) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF754B32),
      ),
      padding: EdgeInsets.all(5),
      child: SvgPicture.asset(
        icon,
        theme: const SvgTheme(
          currentColor: Colors.white,
        ),
      ),
    );
  }
}
