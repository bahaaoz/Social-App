import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:socialapp/DataManagment/firebaseManager.dart';

class NotificationManager {
  FirebaseManager firebaseManager = FirebaseManager();

  Future<void> addNewTokenToUser() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await firebaseManager.addNewTokenToUser(token);
    }
  }

  Future<void> sendNotification(String body, String uid) async {
    List<String> list = await firebaseManager.getUserTokens(uid);
    for (String token in list) {
      await firebaseManager.sendNotification("Social", body, token);
    }
  }
}
