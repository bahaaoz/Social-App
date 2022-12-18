import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/DataManagment/dataController.dart';
import 'package:socialapp/DataManagment/firebaseManager.dart';
import 'package:socialapp/DataManagment/post.dart';
import 'package:socialapp/DynamicLink/dynamicLinkController.dart';

class PostScreen extends StatefulWidget {
  String? postId;
  PostScreen({super.key, this.postId});

  @override
  State<PostScreen> createState() => _PostScreenState(postId: this.postId);
}

class _PostScreenState extends State<PostScreen> {
  String? postId;
  _PostScreenState({this.postId});

  FirebaseManager firebaseManager = FirebaseManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: firebaseManager.readOnePost(postId!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Post? post = snapshot.data as Post?;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/icon.jpg"),
                            radius: 20,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        Text(
                          post!.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              print("bahaa");
                              DynamicLinkController()
                                  .createLink(post.postID.toString())
                                  .then((value) {
                                FlutterShare.share(
                                    title: "social", linkUrl: value);
                              });
                            },
                            icon: const Icon(
                              FontAwesomeIcons.ellipsisVertical,
                            ))
                      ],
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 500,
                        minHeight: 400,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          post.imgPath!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Consumer<DataController>(
                          builder: (context, dataController, child) {
                            return IconButton(
                              onPressed: () async {
                                setState(() {
                                  post.isLike = !post.isLike!;
                                });
                                await dataController.manageLike(
                                  post.isLike!,
                                  post,
                                );
                              },
                              icon: Icon(
                                post.isLike ?? false
                                    ? FontAwesomeIcons.solidHeart
                                    : FontAwesomeIcons.heart,
                                color: post.isLike ?? false ? Colors.red : null,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.comment,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.paperPlane,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.bookmark_border_outlined,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              ("${post.likes.length} ${"likes".tr}"),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 10,
                              child: Text(post.description.toString()),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "View All comments".tr,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
