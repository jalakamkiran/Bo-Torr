import 'package:get/get.dart';
import 'package:libgen/routes/app_routes.dart';


class SplashScreenLogic extends GetxController {


  @override
  void onInit() async{
     Future.delayed(const Duration(seconds: 5)).then((e){
       Get.toNamed(AppRoutes.landingPage);
     });
  }
}
