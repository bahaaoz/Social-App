import 'package:abcamera/abcamera.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socialapp/CustomMaterial/bottomNavbar.dart';
import 'package:socialapp/Screens/camera.dart';
import 'package:socialapp/Screens/home.dart';
import 'package:socialapp/Screens/profile.dart';
import 'package:socialapp/Screens/viewImageAfterTake.dart';
import 'package:camera/camera.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({Key? key}) : super(key: key);

  @override
  State<ScreenManager> createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          FontAwesomeIcons.plus,
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
                ),
              ),
            );
          }
        },
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          Home(),
          Home(), //will change it
          Camera(),
          Home(), //will change it
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavbar(pageController: pageController),
    );
  }

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
}
