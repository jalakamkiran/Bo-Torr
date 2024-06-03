import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:libgen/models/home_page_model.dart';
import 'package:libgen/res.dart';
import 'book_view_logic.dart';

class BookViewPage extends StatelessWidget {
  final logic = Get.find<BookViewLogic>();

  @override
  Widget build(BuildContext context) {
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
            Container(
              height: 500,
              child: Column(
                children: [
                  Row(
                    children: [

                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
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
                    child: Image.network(
                      logic.book.coverurl,
                      fit: BoxFit.scaleDown,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: Text(
                  logic.book.title,
                  style: const TextStyle(
                      color: Color(0xFFEEEAE6),
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
                      color: Color(0xFFEEEAE6),
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
