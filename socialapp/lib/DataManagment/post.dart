import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? postID;
  String? name;
  String? uid;
  String? imgPath;
  CollectionReference<Map<String, dynamic>>? likes;
  int? numberOfLike;
  DateTime? shareTime;
  String? description;
  List? comments;
  bool? isLike;

  Post({
    this.isLike,
    this.numberOfLike,
    this.postID,
    this.uid,
    this.likes,
    this.imgPath,
    this.comments,
    this.description,
    this.name,
    this.shareTime,
  });
}
