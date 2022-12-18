import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:image_cropper/image_cropper.dart';

typedef OnTakePhoto = Widget? Function(File photoFile);
typedef OnSelectPhoto = Widget? Function(File photoFile);

// ignore: must_be_immutable
class ABCamera extends StatefulWidget {
  List<CameraDescription> cameraDescription;
  OnTakePhoto capturedImage;
  OnSelectPhoto selectedIamge;
  ABCamera(
      {Key? key,
      required this.cameraDescription,
      required this.capturedImage,
      required this.selectedIamge})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ABCamera> createState() =>
      // ignore: no_logic_in_create_state
      _ABCameraState(cameraDescription, capturedImage, selectedIamge);
}

class _ABCameraState extends State<ABCamera> {
  CameraController? cameraController;
  Future<void>? cameraValue;
  XFile? takePhoto;
  int cameraMode = 0;
  List<File> allFiles = [];
  ImagePicker imagePicker = ImagePicker();
  List<CameraDescription>? cameraDescription;
  //
  OnTakePhoto capturedImage;
  OnSelectPhoto selectedIamge;
  //
  _ABCameraState(
      this.cameraDescription, this.capturedImage, this.selectedIamge);

  @override
  void initState() {
    cameraController = CameraController(
        cameraDescription![cameraMode], ResolutionPreset.veryHigh);
    cameraValue = cameraController!.initialize();
    readGallary();
    super.initState();
  }

  List<FileSystemEntity> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: FutureBuilder(
                future: cameraValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(
                      cameraController!,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Positioned(
              bottom: 30,
              left: MediaQuery.of(context).size.width / 2 - 40,
              right: MediaQuery.of(context).size.width / 2 - 40,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Colors.white,
                  ),
                ),
                child: MaterialButton(
                  splashColor: Colors.transparent,
                  onPressed: () async {
                    cameraController!.setFlashMode(FlashMode.off);
                    takePhoto = await cameraController!.takePicture();
                    CroppedFile? croppedFile =
                        await croppedFileMethod(takePhoto!.path);

                    capturedImage(File(croppedFile!.path));
                  },
                ),
              ),
            ),
            Positioned(
              top: 35,
              left: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ),
            Positioned(
              bottom: 35,
              left: 30,
              child: IconButton(
                onPressed: () async {
                  takePhoto =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  CroppedFile? croppedFile =
                      await croppedFileMethod(takePhoto!.path);
                  selectedIamge(File(croppedFile!.path));
                },
                icon: const Icon(
                  FontAwesomeIcons.image,
                ),
              ),
            ),
            Positioned(
              bottom: 35,
              right: 30,
              child: IconButton(
                onPressed: () async {
                  setState(() {
                    cameraMode = cameraMode == 0 ? 1 : 0;
                    cameraController = CameraController(
                      cameraDescription![cameraMode],
                      ResolutionPreset.veryHigh,
                    );

                    cameraValue = cameraController!.initialize();
                  });
                },
                icon: const Icon(
                  FontAwesomeIcons.cameraRotate,
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              right: 5,
              left: 5,
              child: SizedBox(
                height: 65,
                child: allFiles.isNotEmpty
                    ? ListView.builder(
                        itemCount: allFiles.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              height: 65,
                              width: 65,
                              color: const Color.fromARGB(51, 0, 0, 0),
                              child: Image.file(
                                allFiles[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            onTap: () async {
                              File f = allFiles[index];

                              CroppedFile? croppedFile =
                                  await croppedFileMethod(f.path);

                              selectedIamge(File(croppedFile!.path));
                            },
                          );
                        },
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<CroppedFile?> croppedFileMethod(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            activeControlsWidgetColor: Colors.blue,
            toolbarTitle: 'Edit Size',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Edit Size',
        ),
        // ignore: use_build_context_synchronously
        WebUiSettings(
          context: context,
        ),
      ],
    );
    return croppedFile;
  }

  readGallary() async {
    List<Album> list =
        await PhotoGallery.listAlbums(mediumType: MediumType.image);

    MediaPage mediaPage = await list[0].listMedia();
    List<Medium> listMedium = mediaPage.items;

    int setStateListener = 0;
    for (var item in listMedium) {
      allFiles.add(await item.getFile());
      setStateListener++;

      if (setStateListener == 10 ||
          setStateListener == 50 ||
          setStateListener == 100 ||
          setStateListener == 200 ||
          setStateListener == 500 ||
          setStateListener == 1000 ||
          setStateListener == list[0].count) {
        print(setStateListener);
        setState(() {});
      }
    }
  }
}
