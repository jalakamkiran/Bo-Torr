import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/models/home_page_model.dart';
import 'package:libgen/modules/home_page/home_page_logic.dart';
import 'package:libgen/modules/home_page/widgets/book_card.dart';

class ListBooks extends StatelessWidget {

  List<Books> books;

  ListBooks({super.key,required this.books});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
            child: BookCard(
              book: books[index],
            ),
          );
        },
      ),
    );
  }
}
