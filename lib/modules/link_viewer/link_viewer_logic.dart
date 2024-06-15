import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/common_widgets/app_button.dart';
import 'package:libgen/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkViewerLogic extends GetxController {
  var arguments = Get.arguments;

  late List<dynamic> downloadUrls;
  late String pages;
  late String md5;

  @override
  void onInit() {
    downloadUrls = arguments['downloadUrls'];
    pages = arguments['totalPages'];
    md5 = arguments['md5'];
    super.onInit();
  }

  void onLinkTapped(String url) {
    if(url.toString().contains("libgen.rs")){
      _showDownloadDialog(url);
    }
    else{
      Get.toNamed(AppRoutes.pdfViewer, arguments: {
        'downloadUrl':url,
        'totalPages':pages,
        'md5': md5
      });
    }
  }

  void _showDownloadDialog(String url) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Flexible(
              child: Text(
                'We are implementing a feature to download book from this URL directly from app. Till then you will be redirected to a Chrome window where you can download the book.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black
                ),
              ),
            ),
            SizedBox(height: 20.0),
            AppButton(onTap: ()async{

              await launchUrl(Uri.parse(url));
              Get.back();
            }, isLoading: false),
          ],
        ),
      ),
    ));
  }

  computeBannerMessage(int index) {
    String url = downloadUrls[index].toString();
    if(url.contains("libgen.rs")){
      return "Ads";
    }
    else if(url.contains(".lol")){
      return "Recmd.";
    }
    return "Direct";
  }
}
