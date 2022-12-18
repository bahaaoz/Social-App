import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:socialapp/Sign/signin.dart';
import 'package:socialapp/Sign/signup.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 50,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabs: [
                        Tab(
                          text: "SignIn".tr,
                        ),
                        Tab(
                          text: "SignUp".tr,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 5,
              ),
              Expanded(
                flex: 30,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    SignIn(),
                    SignUp(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
