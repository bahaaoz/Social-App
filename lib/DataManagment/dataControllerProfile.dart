import 'package:flutter/material.dart';
import 'package:socialapp/DataManagment/firebaseManager.dart';
import 'package:socialapp/DataManagment/post.dart';

class DataControllerProfile extends ChangeNotifier {
  FirebaseManager firebaseManager = FirebaseManager();

  DataControllerProfile() {
    loadMyPosts();
  }

  List<Post> myPosts = [];
  Future<void> loadMyPosts() async {
    myPosts = await firebaseManager.loadMyPosts();
    notifyListeners();
  }
}
