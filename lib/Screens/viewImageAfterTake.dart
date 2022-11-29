import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/Screens/createPost.dart';

class ViewImageAfterTake extends StatelessWidget {
  final imagePath;
  const ViewImageAfterTake({this.imagePath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.green,
        child: IconButton(
          color: Colors.white,
          icon: const Icon(FontAwesomeIcons.check),
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
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(),
          Container(
            child: Row(children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
              )
            ]),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width,
            child: Image.file(
              File(
                imagePath,
              ),
              fit: BoxFit.contain,
            ),
          ),
        ],
      )),
    );
  }
}
