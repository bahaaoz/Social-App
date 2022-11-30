import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/AuthController/authController.dart';
import 'package:socialapp/DataManagment/post.dart';
import 'package:http/http.dart' as http;

class FirebaseManager {
  AuthController authController = AuthController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNewPost(String url, String description) async {
    firebaseFirestore.collection("posts").add({
      "name": authController.username,
      "path": url,
      "uid": authController.uid,
      "description": description.trim(),
      "sharetime": Timestamp.now(),
    }).then((value) {
      value.collection("likes").doc(value.id);
    });
  }

  Future<List<Post>> readPosts() async {
    var response = await firebaseFirestore
        .collection("posts")
        .orderBy("sharetime", descending: true)
        .get();
    List<Post> list = [];
    for (var x in response.docs) {
      Post p = Post(
        postID: x.id,
        name: x.get("name"),
        isLike: false,
        description: x.get("description"),
        imgPath: x.get("path"),
        uid: x.get("uid"),
        shareTime: DateTime.fromMicrosecondsSinceEpoch(
          x.get("sharetime").millisecondsSinceEpoch,
        ),
      );
      var temp = await firebaseFirestore
          .collection("posts")
          .doc(p.postID)
          .collection("likes")
          .get();

      for (var t in temp.docs) {
        p.likes[t.id] = true;
      }

      if (p.likes[authController.uid] == true) {
        p.isLike = true;
      }

      list.add(p);
    }

    return list;
  }

  Future<void> addLike(Post post) async {
    await firebaseFirestore
        .collection("posts")
        .doc(post.postID)
        .collection("likes")
        .doc(authController.uid)
        .set({
      "islike": true,
    });

    await reReadPost(post);
  }

  Future<void> removeLike(Post post) async {
    await firebaseFirestore
        .collection("posts")
        .doc(post.postID)
        .collection("likes")
        .doc(authController.uid)
        .delete();

    await reReadPost(post);
  }

  Future<void> reReadPost(Post post) async {
    var response =
        await firebaseFirestore.collection("posts").doc(post.postID).get();

    post.description = response.get("description");

    var temp = await firebaseFirestore
        .collection("posts")
        .doc(post.postID)
        .collection("likes")
        .get();
    post.likes.clear();
    for (var t in temp.docs) {
      post.likes[t.id] = true;
    }

    if (post.likes[authController.uid] == true) {
      post.isLike = true;
    } else {
      post.isLike = false;
    }
  }

  //read my posts
  Future<List<Post>> loadMyPosts() async {
    var response = await firebaseFirestore
        .collection("posts")
        .where("uid", isEqualTo: authController.uid)
        .get();
    List<Post> list = [];
    for (var x in response.docs) {
      Post p = Post(
        postID: x.id,
        name: x.get("name"),
        isLike: false,
        description: x.get("description"),
        imgPath: x.get("path"),
        uid: x.get("uid"),
        shareTime: DateTime.fromMicrosecondsSinceEpoch(
          x.get("sharetime").millisecondsSinceEpoch,
        ),
      );
      var temp = await firebaseFirestore
          .collection("posts")
          .doc(p.postID)
          .collection("likes")
          .get();

      for (var t in temp.docs) {
        p.likes[t.id] = true;
      }

      if (p.likes[authController.uid] == true) {
        p.isLike = true;
      }

      list.add(p);
    }

    return list;
  }

  //notification

  Future<void> sendNotification(String title, String body, String to) async {
     String serverToken =
        "AAAALkhvyeU:APA91bEx51B_w5PnEyhyiVcNohxw1wICnc0MjBSxn91bhVXes06GhEsJGhCA8y04HoLwR7fXCFWMXgHC3K5sWsA4q9Sug9Xnnz4Y_GwG8Wu_RE_DDVFofBQD7wJmKqaR6dtwgzK28R8a";
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': to,
        },
      ),
    );
  }

  //add new token
  Future<void> addNewTokenToUser(String token) async {
    await firebaseFirestore
        .collection("tokens")
        .doc(authController.uid)
        .collection("mytokens")
        .doc(token)
        .set({
      "active": true,
    });
  }

  //get user tokens
  Future<List<String>> getUserTokens(String uid) async {
    var response = await firebaseFirestore
        .collection("tokens")
        .doc(uid)
        .collection("mytokens")
        .get();
    List<String> list = [];
    for (var x in response.docs) {
      list.add(x.id);
    }

    return list;
  }
}
