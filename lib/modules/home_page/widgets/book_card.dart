import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/app_colors.dart';
import 'package:libgen/models/home_page_model.dart';
import 'package:libgen/modules/utils/book_data.dart';
import 'package:libgen/routes/app_routes.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookCard extends StatelessWidget {
  Books book;

  BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onBookCardTapped,
      child: Material(
        elevation: 5,
        shadowColor: Colors.white38,
        color: Colors.transparent,
        child: Container(
          decoration: _bookCardDecoration(),
          child: Column(
            children: [
              _bookCoverImage(),
            ],
          ),
        ),
      ),
    );
  }

  void _onBookCardTapped() {
    Get.toNamed(
      AppRoutes.bookView,
      arguments: {'book': book.toJson()},
    );
  }

  Widget _bookCoverImage() {
    return Expanded(
      child: Skeleton.replace(
        height: double.infinity,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Hero(
            tag: book,
            transitionOnUserGestures: true,
            child: CachedNetworkImage(
              fadeInCurve: Curves.easeIn,
              imageUrl: book.coverurl,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _bookCardDecoration() {
    return BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
      BoxShadow(
        color: Color(0xFF121212),
      )
    ]);
  }

  Widget _onloadingBuilder(context, child, event) {
    if (event == null) {
      return child;
    }
    return Skeletonizer.zone(
      effect: ShimmerEffect(),
      child: Container(
        height: 100,
        width: double.infinity,
      ),
    );
  }
}
