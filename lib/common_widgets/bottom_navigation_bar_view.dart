import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/app_colors.dart';
import 'package:libgen/modules/landing_page/landing_page_logic.dart';
import 'package:libgen/res.dart';

import '../modules/bottom_navigation_bar/bottom_navigation_bar_logic.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBarView extends StatelessWidget {
  BottomNavigationBarView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageLogic>(
      builder: (logic) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: inActiveBottomBarColor,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              logic.bottomNavigationBarItems.length,
              (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 0),
                    child: InkWell(
                      customBorder: CircleBorder(),
                      onTap: () {
                        logic.onItemTapped(index);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            logic.bottomNavigationBarItems[index].icon,
                            theme: SvgTheme(
                                currentColor: _computeIsActive(logic, index)),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Flexible(
                            child: Text(
                              logic.bottomNavigationBarItems[index].title,
                              style: TextStyle(
                                  color: _computeIsActive(logic, index),
                                  letterSpacing: 0.8),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Color _computeIsActive(LandingPageLogic logic, int index) {
    return logic.bottomNavigationBarItems[index].state ==
            logic.bottomNavigationBarState
        ? Color(0xFFA3C9E2)
        : inActiveBottomBarColor;
  }
}
