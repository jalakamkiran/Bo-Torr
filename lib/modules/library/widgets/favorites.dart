import 'package:flutter/material.dart';
import 'package:libgen/models/home_page_model.dart';
import 'package:libgen/modules/home_page/widgets/book_card.dart';
import 'package:libgen/modules/home_page/widgets/list_books.dart';

class Favorites extends StatelessWidget {
  List<Books> books;

  Favorites({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            child: BookCard(
              book: books[index],
              considerInfiniteConstraints: false,
            ),
          );
        },
      ),
    );
  }
}
