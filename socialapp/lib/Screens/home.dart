import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/AuthController/authController.dart';
import 'package:socialapp/CustomMaterial/bottomNavbar.dart';
import 'package:socialapp/DataManagment/dataController.dart';

import '../CustomMaterial/top_appbar.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(),
      bottomNavigationBar: const BottomNavbar(),
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
                                    color: const Color.fromARGB(
                                        107, 180, 180, 180)),
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
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesomeIcons.ellipsisVertical,
                                ))
                          ],
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 450,
                            minHeight: 400,
                          ),
                          child: Image.network(
                              dataController.postList[goodIndex].imgPath!),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                if (dataController
                                    .postList[goodIndex].isLike!) {
                                  await dataController.addLike(
                                      goodIndex,
                                      dataController
                                          .postList[goodIndex].postID!,
                                      authController.uid.toString());
                                } else {
                                  await dataController.removeLike(
                                      goodIndex,
                                      dataController
                                          .postList[goodIndex].postID!,
                                      authController.uid.toString());
                                }
                              },
                              icon: const Icon(
                                FontAwesomeIcons.heart,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              ("${dataController.postList[goodIndex].numberOfLike} ${"likes".tr}"),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 10,
                              child: Text(dataController
                                  .postList[goodIndex].description
                                  .toString()),
                            )
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
