import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/DataManagment/firebaseManager.dart';
import 'package:uuid/uuid.dart';

class CreatePost extends StatefulWidget {
  File file;
  CreatePost({Key? key, required this.file}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<CreatePost> createState() => _CreatePostState(file: file);
}

class _CreatePostState extends State<CreatePost> {
  File file;
  _CreatePostState({required this.file});
  UploadTask? uploadTask;
  bool prograss = false;
  FirebaseManager firebaseManager = FirebaseManager();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          FontAwesomeIcons.solidPaperPlane,
        ),
        onPressed: () async {
          await uploudPost();
          Navigator.of(context).pop();
        },
      ),
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: screenSize.width - 20,
                      maxHeight: screenSize.height / 2,
                    ),
                    child: Image.file(
                      file,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                height: 1,
                width: screenSize.width,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(91, 158, 158, 158),
                ),
              ),
            ],
          ),
          prograss
              ? Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  color: const Color.fromARGB(192, 114, 114, 114),
                  child: Center(
                    child: StreamBuilder<TaskSnapshot>(
                        stream: uploadTask!.snapshotEvents,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircularProgressIndicator(
                              value: snapshot.data!.bytesTransferred /
                                  snapshot.data!.totalBytes,
                            );
                          } else {
                            return Container();
                          }
                        }),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  var uuid = const Uuid();
  Future<void> uploudPost() async {
    try {
      setState(() {
        prograss = true;
      });
      String name = basename(file.path);
      List<String> str = name.split(".");

      var response = FirebaseStorage.instance
          .ref()
          .child("imageposts/${uuid.v4()}.${str[str.length - 1]}");
      setState(() {
        uploadTask = response.putFile(file);
      });
      await uploadTask!.whenComplete(() {});
      String urlDownload = await response.getDownloadURL();
      // await firebaseManager.addNewPost(urlDownload, description.text);
      setState(() {
        prograss = false;
      });
    } catch (ee) {
      setState(() {
        prograss = false;
      });
    }
  }
}
