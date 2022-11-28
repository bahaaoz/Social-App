import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/AuthController/authController.dart';
import 'package:socialapp/DataManagment/post.dart';

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
      value.collection("likes").doc(value.id).set({
        "like": false,
      });
    });
  }

  Future<List<Post>> readPosts() async {
    var response = await firebaseFirestore.collection("posts").get();
    List<Post> list = [];
    for (var x in response.docs) {
      Post p = Post(
        postID: x.id,
        name: x.get("name"),
        description: x.get("description"),
        imgPath: x.get("path"),
        uid: x.get("uid"),
        shareTime: DateTime.fromMicrosecondsSinceEpoch(
          x.get("sharetime").millisecondsSinceEpoch,
        ),
      );
      var temp = firebaseFirestore
          .collection("posts")
          .doc(p.postID)
          .collection("likes");

      p.likes = temp;
      await temp.where("islike", isEqualTo: true).get().then((value) {
        p.numberOfLike = value.size;
      });

      list.add(p);
    }

    return list;
  }

  Future<void> addLike(String postId, String userId) async {
    await firebaseFirestore
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(userId)
        .set({
      "islike": true,
    }, SetOptions(merge: true));
  }

  Future<void> removeLike(String postId, String userId) async {
    await firebaseFirestore
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(userId)
        .set({
      "islike": false,
    }, SetOptions(merge: true));
  }
}
