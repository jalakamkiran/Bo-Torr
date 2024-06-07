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
        suffixIcon: InkWell(
          onTap: logic.onClearPressed,
          child: const Icon(
            Icons.clear_rounded,
            color: inActiveBottomBarColor,
          ),
        ),
        filled: true,
        hintStyle: const TextStyle(
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
          return _showBooks(logic);
        case SearchPageState.error:
          return Text("Error occured");
        case SearchPageState.idle:
          return  const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text("Start searching to find recommendations",),
              ],
            ),
          );
      }
    });
  }

  Expanded _showBooks(SearchPageLogic logic) {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: logic.searchResult.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: BookCard(
              book: logic.searchResult[index],
            ),
          );
        },
      ),
    );
  }
}
