import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/Localization/localeController.dart';
import 'package:socialapp/Theme/theme_controller.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ThemeController>(context);
    var controllerLocale = Get.put(LocaleController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Setting".tr,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              color: Colors.white,
                              onPressed: () {
                                controller.changeTheme(false);
                              },
                              child: const Text(
                                "Light",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            MaterialButton(
                              color: Colors.black,
                              onPressed: () {
                                controller.changeTheme(true);
                              },
                              child: const Text(
                                "Dark",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  const Icon(FontAwesomeIcons.brush),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Theme".tr,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              color: Colors.black,
                              onPressed: () {
                                controllerLocale.changeLocal("ar");
                              },
                              child: const Text(
                                "عربي",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            MaterialButton(
                              color: Colors.black,
                              onPressed: () {
                                controllerLocale.changeLocal("en");
                              },
                              child: const Text(
                                "English",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  const Icon(FontAwesomeIcons.earthAmericas),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Languge".tr,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
