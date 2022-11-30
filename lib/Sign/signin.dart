import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:socialapp/AuthController/authController.dart';
import 'package:socialapp/DataManagment/notificationManager.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  NotificationManager notificationManager = NotificationManager();

  String errortext = "";
  Color errorColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email,
                ),
                label: Text(
                  "email".tr,
                ),
              ),
            ),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.lock,
                ),
                label: Text(
                  "password".tr,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              height: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    50,
                  ),
                ),
              ),
              child: MaterialButton(
                child: Text(
                  "Login".tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  bool signIn = await _authController.signIn(
                      _emailController.text, _passwordController.text);

                  if (signIn) {
                    setState(() {
                      errortext = "";
                    });
                    await notificationManager.addNewTokenToUser();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context)
                        .pushReplacementNamed("/screenManager");
                  } else {
                    setState(() {
                      errortext = "email or password is wrong";
                      errorColor = Colors.red;
                    });
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errortext,
                    style: TextStyle(
                      color: errorColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
