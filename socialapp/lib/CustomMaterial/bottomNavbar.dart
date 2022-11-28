import 'dart:io';

import 'package:abcamera/abcamera.dart';
import 'package:app_settings/app_settings.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socialapp/Screens/createPost.dart';

import '../Screens/viewImageAfterTake.dart';

List<CameraDescription> cameraDis = [];

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  // 0 => isPermanentlyDenied
  // 1 => isGranted
  // 2 => isDenied
  Future<int> getPermission(Permission permission) async {
    var request = await permission.request();
    if (request.isGranted) {
      return 1;
    } else if (request.isPermanentlyDenied) {
      return 0;
    } else {
      return 2;
    }
  }

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
            Navigator.of(context).pushReplacementNamed("/home");
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.search_rounded,
            size: 25,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.circlePlus,
            size: 35,
          ),
          onPressed: () async {
            int storage = await getPermission(Permission.storage);
            int camera = await getPermission(Permission.camera);
            if (storage == 0 || camera == 0) {
              await AppSettings.openAppSettings();
            } else if (storage == 1 && camera == 1) {
              cameraDis = await availableCameras();
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ABCamera(
                    cameraDescription: cameraDis,
                    capturedImage: (photo) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewImageAfterTake(imagePath: photo.path),
                        ),
                      );
                    },
                    selectedIamge: (photoFile) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewImageAfterTake(
                            imagePath: photoFile.path,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.notifications,
            size: 25,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.person,
            size: 25,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/profile");
          },
        ),
      ],
    ));
  }
}
