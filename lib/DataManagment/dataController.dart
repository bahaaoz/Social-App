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

    notifyListeners();
  }

  Future<void> manageLike(bool like, Post post) async {
    print(like);
    if (like) {
      await _addLike(post);
    } else {
     await _removeLike(post);
    }
    notifyListeners();
  }

  Future<void> _addLike(Post post) async {
    await firebaseManager.addLike(post);
  }

  Future<void> _removeLike(Post post) async {
    await firebaseManager.removeLike(post);
  }
}
