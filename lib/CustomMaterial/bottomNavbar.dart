import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../DynamicLink/dynamicLinkController.dart';

List<CameraDescription> cameraDis = [];

class BottomNavbar extends StatelessWidget {
  PageController? pageController;
  BottomNavbar({Key? key, this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(
            Icons.home,
            size: 25,
          ),
          onPressed: () {
            pageController!.jumpToPage(0);
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.search_rounded,
            size: 25,
          ),
          onPressed: () {},
        ),
        const Text(""),
        IconButton(
          icon: const Icon(
            Icons.notifications,
            size: 25,
          ),
          onPressed: ()   {
           },
        ),
        IconButton(
          icon: const Icon(
            Icons.person,
            size: 25,
          ),
          onPressed: () {
            pageController!.jumpToPage(4);
          },
        ),
      ],
    ));
  }
}
