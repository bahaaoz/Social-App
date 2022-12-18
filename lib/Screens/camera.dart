import 'package:abcamera/abcamera.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/CustomMaterial/bottomNavbar.dart';
import 'package:socialapp/Screens/viewImageAfterTake.dart';


class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ABCamera(
            cameraDescription: cameraDis,
            capturedImage: (photo) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewImageAfterTake(imagePath: photo.path),
                ),
              );
              return null;
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
              return null;
            },
          ),);
  }
}