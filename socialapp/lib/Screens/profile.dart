import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialapp/AuthController/authController.dart';
import 'package:socialapp/CustomMaterial/bottomNavbar.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthController firebaseAuth = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/setting");
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.settings,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Setting".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            MaterialButton(
              onPressed: () async {
                await firebaseAuth.logout();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacementNamed("/signin");
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.logout,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Logout".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
      bottomNavigationBar: BottomNavbar(),
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 50,
                backgroundImage: AssetImage(
                  "assets/yoneheight.jpg",
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              firebaseAuth.username!,
              style: GoogleFonts.aBeeZee(
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "bio".tr,
              style: GoogleFonts.aBeeZee(
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
