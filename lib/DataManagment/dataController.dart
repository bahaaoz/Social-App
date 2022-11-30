import 'package:flutter/material.dart';
import 'package:socialapp/AuthController/authController.dart';
import 'package:socialapp/DataManagment/firebaseManager.dart';
import 'package:socialapp/DataManagment/notificationManager.dart';
import 'package:socialapp/DataManagment/post.dart';

class DataController extends ChangeNotifier {
  DataController() {
    loadPosts();
  }

  List<Post> postList = [];
  FirebaseManager firebaseManager = FirebaseManager();
  NotificationManager notificationManager = NotificationManager();
  AuthController authController = AuthController();

  int get size => postList.length;

  Future<void> loadPosts() async {
    List<Post> tempList = await firebaseManager.readPosts();

    postList.addAll(tempList);

    notifyListeners();
  }

  Future<void> manageLike(bool like, Post post) async {
     if (like) {
      await _addLike(post);
    } else {
      await _removeLike(post);
    }
    notifyListeners();
  }

  Future<void> _addLike(Post post) async {
    await firebaseManager.addLike(post);
    await notificationManager.sendNotification(
        "Your post was liked by ${authController.username}", post.uid ?? "");
  }

  Future<void> _removeLike(Post post) async {
    await firebaseManager.removeLike(post);
  }
}
