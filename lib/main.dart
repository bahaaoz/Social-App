import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapp/DataManagment/dataController.dart';
import 'package:socialapp/DataManagment/dataControllerProfile.dart';
import 'package:socialapp/DynamicLink/dynamicLinkController.dart';
import 'package:socialapp/Localization/localeController.dart';
import 'package:socialapp/Localization/myLocale.dart';
import 'package:socialapp/Screens/home.dart';
import 'package:socialapp/Screens/profile.dart';
import 'package:socialapp/Screens/screenManager.dart';
import 'package:socialapp/Screens/settings.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/Screens/splash.dart';
import 'package:socialapp/Screens/viewImageAfterTake.dart';
import 'package:socialapp/Sign/sign.dart';

import 'Theme/theme_controller.dart';

SharedPreferences? sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  sharedPreferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}
//fK-6trZ-RLuiJTFsKyx6qt:APA91bEwYr3bLamx-aHPim1LUPONZT9NA-qWgdaQYPMi9tOa-wCnbfM_ANCNp612jK-iq3L67vml37OWxbuNOOQfHO7nyhbm3QNKEguYG5aIcb_rBCWeUU59FqH-T4Nxn1Y8ZUN2AkVa

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataControllerProfile(),
        ),
      ],
      child: Consumer<ThemeController>(
        builder: (context, controller, child) {
          LocaleController local = LocaleController();
          return GetMaterialApp(
            translations: MyLocale(),
            locale: local.initialLocale,
            theme: controller.theme
                ? ThemeData(
                    floatingActionButtonTheme:
                        const FloatingActionButtonThemeData(
                      backgroundColor: Colors.white,
                      elevation: 10,
                      foregroundColor: Colors.black,
                    ),
                    tabBarTheme: TabBarTheme(
                      labelColor: Colors.white,
                      labelStyle: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      indicator: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(255, 244, 127, 54),
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                    bottomAppBarTheme: const BottomAppBarTheme(
                      color: Colors.black,
                    ),
                    scaffoldBackgroundColor: Colors.black,
                    brightness: Brightness.dark,
                    appBarTheme: const AppBarTheme(
                      iconTheme: IconThemeData(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.black,
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                  )
                : ThemeData(
                    floatingActionButtonTheme:
                        const FloatingActionButtonThemeData(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    tabBarTheme: TabBarTheme(
                      labelColor: Colors.black,
                      labelStyle: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      indicator: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(255, 54, 238, 244),
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                    scaffoldBackgroundColor: Colors.white,
                    brightness: Brightness.light,
                    appBarTheme: const AppBarTheme(
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                      ),
                    ),
                  ),
            debugShowCheckedModeBanner: false,
            routes: {
              "/home": (context) => const Home(),
              "/profile": (context) => const Profile(),
              "/setting": (context) => const Setting(),
              "/signin": (context) => const Sign(),
              "/viewImage": (context) => const ViewImageAfterTake(),
              "/screenManager": (context) => const ScreenManager(),
            },
            title: "Social App",
            home: const Splash(),
          );
        },
      ),
    );
  }
}
