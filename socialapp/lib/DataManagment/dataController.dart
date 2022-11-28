import 'package:flutter/material.dart';
import 'package:socialapp/DataManagment/firebaseManager.dart';
import 'package:socialapp/DataManagment/post.dart';

class DataController extends ChangeNotifier {
  DataController() {
    loadPosts();
  }

  List<Post> postList = [];
  FirebaseManager firebaseManager = FirebaseManager();

  int get size => postList.length;

  Future<void> loadPosts() async {
    List<Post> tempList = await firebaseManager.readPosts();

    postList.addAll(tempList);

    print(postList.length);
    notifyListeners();
  }

  Future<void> addLike(int index, String postId, String userId) async {
    await firebaseManager.addLike(postId, userId);
    postList[index].isLike = true;
    postList[index].numberOfLike = (postList[index].numberOfLike! + 1);
    notifyListeners();
  }

  Future<void> removeLike(int index, String postId, String userId) async {
    await firebaseManager.removeLike(postId, userId);
    postList[index].numberOfLike = (postList[index].numberOfLike! - 1);

    postList[index].isLike = false;
    notifyListeners();
  }
}
