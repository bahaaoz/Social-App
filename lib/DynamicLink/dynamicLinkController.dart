import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/Screens/postScreen.dart';

class DynamicLinkController {
  StreamSubscription? _sub;

  void initDynamicLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen(
      (event) async {
        Uri uriStr = event.link;
        var str = uriStr.queryParameters["id"];
        print(str);
        if (str != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostScreen(postId: str),
            ),
          );
        }
      },
    );

    PendingDynamicLinkData? pendingDynamicLinkData =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (pendingDynamicLinkData != null) {
      Uri uriStr = pendingDynamicLinkData.link;
      bool check = uriStr.pathSegments.contains("id");

      if (check) {
        String str = uriStr.queryParameters["id"].toString();
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostScreen(postId: str),
            ));
      }
    }
  }

  Future<String> createLink(String ref) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse("https://social-app-9afc3.firebaseapp.com?id=$ref"),
        uriPrefix: "https://testdeeplinkappbahaa.page.link",
        androidParameters: AndroidParameters(
          fallbackUrl: Uri.parse("https://testdeeplinkappbahaa.page.link"),
          packageName: "com.example.socialapp",
          minimumVersion: 125,
        ),
        iosParameters: const IOSParameters(
          bundleId: "com.example.socialapp",
          minimumVersion: "1.0.1",
        ));

    FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;
    final refLink = await link.buildLink(parameters);
    print(refLink.toString());
    return refLink.toString();
  }
}
