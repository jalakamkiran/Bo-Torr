import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:libgen/app_theme.dart';
import 'package:libgen/initialize_sdk.dart';
import 'package:libgen/res.dart';
import 'package:libgen/routes/app_pages.dart';
import 'package:libgen/routes/app_routes.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSdk();
  runApp(
    BetterFeedback(
      darkTheme: FeedbackThemeData.dark(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultGlobalState: true,
      title: 'Granthalayam',
      initialRoute: AppRoutes.splashScreen,
      getPages: AppPages.routes,
      theme: AppTheme.themeData,
      builder: EasyLoading.init(
        builder: (context, widget) {
          return ResponsiveBreakpoints(
            child: widget!,
            breakpoints: const [
              Breakpoint(start: 0, end: 360, name: MOBILE),
              Breakpoint(start: 361, end: 500, name: TABLET),
              Breakpoint(start: 501, end: 600, name: DESKTOP),
            ],
          );
        },
      ),
    );
  }
}
