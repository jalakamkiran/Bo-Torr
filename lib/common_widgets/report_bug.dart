import 'package:feedback_sentry/feedback_sentry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportBug extends StatelessWidget {
  const ReportBug({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBugReportTapped,
      child: const Icon(
        Icons.bug_report,
        color: Colors.white,
      ),
    );
  }

  void onBugReportTapped() {
      BetterFeedback.of(Get.context!).showAndUploadToSentry();
  }
}
