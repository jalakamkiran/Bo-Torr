import 'package:flutter/material.dart';
import 'package:libgen/app_colors.dart';

class AppButton extends StatelessWidget {
  Function()? onTap;
  bool isLoading;

  AppButton({required this.onTap, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator(
            color: buttonColor,
          )
        : InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(30)),
              child: const Text(
                "Read now",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
  }
}
