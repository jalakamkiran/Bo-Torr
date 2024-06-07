import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:libgen/app_colors.dart';
import 'package:libgen/modules/home_page/widgets/book_card.dart';
import 'package:libgen/res.dart';
import 'search_page_logic.dart';
import 'package:lottie/lottie.dart';

class SearchPageView extends StatelessWidget {
  SearchPageView({Key? key}) : super(key: key);

  final logic = Get.find<SearchPageLogic>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          _searchTextField(),
          _body(),
        ],
      ),
    );
  }

  TextFormField _searchTextField() {
    return TextFormField(
      controller: logic.searchController,
      style: TextStyle(
          color: primaryTextColor, fontSize: 16, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        hintText: "Search by title",
        fillColor: searchBarColor,
        filled: true,
        hintStyle: TextStyle(
            color: inActiveBottomBarColor,
            fontSize: 16,
            fontWeight: FontWeight.w300),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        prefixIcon: SvgPicture.asset(
          Res.search_icon,
          color: inActiveBottomBarColor,
          fit: BoxFit.scaleDown,
        ),
      ),
      onChanged: logic.onSearchChanged,
    );
  }

  Widget _body() {
    return GetBuilder<SearchPageLogic>(builder: (logic) {
      switch (logic.searchPageState) {
        case SearchPageState.loading:
          return Lottie.asset(Res.searching);
        case SearchPageState.success:
          return Expanded(
            child: GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: logic.searchResult.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                  child: BookCard(
                    book: logic.searchResult[index],
                  ),
                );
              },
            ),
          );
        case SearchPageState.error:
          return Text("Error occured");
        case SearchPageState.idle:
          return Text("Start searching");
      }
    });
  }
}
