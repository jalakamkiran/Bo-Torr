import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/home_page/home_page_logic.dart';
import 'package:libgen/home_page/widgets/book_card.dart';

class ListBooks extends StatelessWidget {
  ListBooks({super.key});

  final logic = Get.find<HomePageLogic>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: logic.books.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
            child: BookCard(
              book: logic.books[index],
            ),
          );
        },
      ),
    );
  }
}
