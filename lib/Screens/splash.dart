import 'package:flutter/material.dart';
import 'package:socialapp/AuthController/authController.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final AuthController authController = AuthController();
  @override
  void initState() {
    super.initState();
    routPage();
  }

  routPage() async {
    bool k = await authController.checkSignIn();
    if (k) {
      Navigator.of(context).pushReplacementNamed("/home");
    } else {
      Navigator.of(context).pushReplacementNamed("/signin");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 233, 113, 0),
        ),
      ),
    );
  }
}
