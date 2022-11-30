import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socialapp/Screens/createPost.dart';

class ViewImageAfterTake extends StatelessWidget {
  final imagePath;
  const ViewImageAfterTake({this.imagePath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
              )
            ],
          ),
          Expanded(
            child: Center(
              child: Image.file(
                File(
                  imagePath,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePost(
                        file: File(imagePath),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.check,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
