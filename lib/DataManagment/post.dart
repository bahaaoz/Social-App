class Post {
  String? postID;
  String? name;
  String? uid;
  String? imgPath;
  Map<String, bool> likes = {};
  DateTime? shareTime;
  String? description;
  List? comments;
  bool? isLike;

  Post({
    this.isLike,
    this.postID,
    this.uid,
    likes,
    this.imgPath,
    this.comments,
    this.description,
    this.name,
    this.shareTime,
  });
}
