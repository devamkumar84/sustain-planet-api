import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
// import 'package:url_launcher/url_launcher.dart' as urlLauncher;
// import 'package:url_launcher/url_launcher.dart';

import '../utils/toast.dart';

class AppService {

  Future<bool?> checkInternet() async {
    bool? internet;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        internet = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      internet = false;
    }
    return internet;
  }

  // Future openLink(context, String url) async {
  //   final uri = Uri.parse(url);
  //   if (await urlLauncher.canLaunchUrl(uri)) {
  //     urlLauncher.launchUrl(uri, mode: LaunchMode.externalApplication);
  //   } else {
  //     openToast1(context, "Can't launch the url");
  //   }
  // }




  Future openLinkWithCustomTab(BuildContext context, String url) async {
    try{
      await FlutterWebBrowser.openWebPage(
        url: url,
        customTabsOptions: const CustomTabsOptions(
          colorScheme: CustomTabsColorScheme.light,
          //addDefaultShareMenuItem: true,
          instantAppsEnabled: true,
          showTitle: true,
          urlBarHidingEnabled: true,
        ),
        safariVCOptions: const SafariViewControllerOptions(
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
          modalPresentationCapturesStatusBarAppearance: true,
        ),
      );
    }catch(e){
      openToast1(context, 'Cant launch the url');
      debugPrint(e.toString());
    }
  }



}