import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/AuthController/authController.dart';
import 'package:socialapp/DataManagment/dataController.dart';
import 'package:socialapp/DynamicLink/dynamicLinkController.dart';
import 'package:socialapp/Screens/profile.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter_share/flutter_share.dart';

import '../CustomMaterial/top_appbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthController authController = AuthController();

  @override
  void initState() {
    super.initState();
    DynamicLinkController().initDynamicLink(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(),
      body: Column(children: [
        Expanded(
          child: Consumer<DataController>(
            builder: (context, dataController, child) {
              return ListView.builder(
                itemCount: dataController.size + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                        margin: const EdgeInsets.only(
                          top: 9,
                          bottom: 10,
                        ),
                        height: 60,
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(107, 180, 180, 180),
                                ),
                                shape: BoxShape.circle,
                              ),
                            );
                          },
                        ));
                  }
                  int goodIndex = index - 1;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
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
                              dataController.postList[goodIndex].name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  print("bahaa");
                                  DynamicLinkController()
                                      .createLink(dataController
                                          .postList[goodIndex].postID
                                          .toString())
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
                              dataController.postList[goodIndex].imgPath!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                setState(() {
                                  dataController.postList[goodIndex].isLike =
                                      !dataController
                                          .postList[goodIndex].isLike!;
                                });
                                await dataController.manageLike(
                                  dataController.postList[goodIndex].isLike!,
                                  dataController.postList[goodIndex],
                                );
                              },
                              icon: Icon(
                                dataController.postList[goodIndex].isLike ??
                                        false
                                    ? FontAwesomeIcons.solidHeart
                                    : FontAwesomeIcons.heart,
                                color:
                                    dataController.postList[goodIndex].isLike ??
                                            false
                                        ? Colors.red
                                        : null,
                              ),
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
                                  ("${dataController.postList[goodIndex].likes.length} ${"likes".tr}"),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 10,
                                  child: Text(dataController
                                      .postList[goodIndex].description
                                      .toString()),
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
                },
              );
            },
          ),
        )
      ]),
    );
  }
}
