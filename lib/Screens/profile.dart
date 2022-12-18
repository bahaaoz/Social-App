import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/AuthController/authController.dart';
import 'package:socialapp/DataManagment/dataControllerProfile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthController firebaseAuth = AuthController();

  List<PaymentItem> get paymentItem {
    return const [
      PaymentItem(
        amount: "1.99",
        label: "BAHAA",
        status: PaymentItemStatus.final_price,
      ),
    ];
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());

    Get.snackbar("wow", "bahaa");
  }

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
            GooglePayButton(
              type: GooglePayButtonType.pay,
              paymentConfigurationAsset:
                  "default_payment_profile_google_pay.json",
              onPaymentResult: onGooglePayResult,
              paymentItems: paymentItem,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
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
              "you you you you you you you you",
              style: GoogleFonts.aBeeZee(
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(79, 158, 158, 158),
            width: double.infinity,
            height: 1,
          ),
          Expanded(
            child: Consumer<DataControllerProfile>(
              builder: (context, dataController, child) {
                return Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: GridView.builder(
                    itemCount: dataController.myPosts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(1),
                        child: Image.network(
                          dataController.myPosts[index].imgPath!,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
