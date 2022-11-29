import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:socialapp/AuthController/authController.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final AuthController _authController = AuthController();
  bool error = false;
  String errortext = "";
  Color errorColor = Colors.red;

  bool hidenCheckPassword = true;
  bool capital = false;
  bool numbers = false;
  bool lowercase = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person,
                ),
                label: Text(
                  "user name".tr,
                ),
              ),
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
              onChanged: (value) {
                if (hidenCheckPassword) {
                  setState(() {
                    hidenCheckPassword = false;
                  });
                }

                if (RegExp(r'[A-Z]')
                    .allMatches(_passwordController.text)
                    .isNotEmpty) {
                  setState(() {
                    capital = true;
                  });
                } else {
                  setState(() {
                    capital = false;
                  });
                }
                if (RegExp(r'[a-z]')
                    .allMatches(_passwordController.text)
                    .isNotEmpty) {
                  setState(() {
                    lowercase = true;
                  });
                } else {
                  setState(() {
                    lowercase = false;
                  });
                }
                if (RegExp(r'[0-9]')
                    .allMatches(_passwordController.text)
                    .isNotEmpty) {
                  setState(() {
                    setState(() {
                      numbers = true;
                    });
                  });
                } else {
                  numbers = false;
                }
              },
            ),
            hidenCheckPassword
                ? Container()
                : Column(
                    children: [
                      Row(
                        children: [
                          checkPassword("lowercase letter", lowercase),
                          checkPassword("numbers", numbers),
                        ],
                      ),
                      checkPassword("capital letter", capital),
                    ],
                  ),
            const SizedBox(
              height: 10,
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
                  "SignUp".tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  if (_usernameController.text.isEmpty ||
                      _passwordController.text.isEmpty ||
                      _emailController.text.isEmpty ||
                      !capital ||
                      !lowercase ||
                      !numbers) {
                    return;
                  }

                  bool signUpRequest = await _authController.signUp(
                      _usernameController.text,
                      _emailController.text,
                      _passwordController.text);

                  if (signUpRequest) {
                    setState(() {
                      errortext = "Done";
                      errorColor = Colors.green;
                      _usernameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                      lowercase = false;
                      capital = false;
                      numbers = false;
                      hidenCheckPassword = true;
                    });
                  } else {
                    setState(() {
                      errortext = "Email already exist";

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
          ],
        ),
      ),
    );
  }

  Container checkPassword(String checkType, bool check) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 7,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            decoration: BoxDecoration(
              color: check
                  ? const Color.fromARGB(255, 196, 255, 227)
                  : Color.fromARGB(255, 247, 135, 127),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  check ? Icons.check : Icons.close,
                  size: 20,
                  color: check
                      ? Color.fromARGB(255, 4, 169, 9)
                      : Color.fromARGB(255, 255, 17, 0),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  checkType,
                  style: TextStyle(
                    color: check
                        ? Color.fromARGB(255, 20, 204, 29)
                        : Color.fromARGB(255, 240, 27, 12),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
