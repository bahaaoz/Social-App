import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLocale extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys {
    return {
      "en": {
        "Theme": "Theme",
        "Languge": "Languge",
        "Setting": "Setting",
        "likes": "likes",
        "View All comments": "View All comments",
        "email": "email",
        "password": "password",
        "Login": "Login",
        "user name": "user name",
        "SignUp": "SignUp",
        "SignIn": "SignIn",
        "Logout": "Logout",
      },
      "ar": {
        "Theme": "السمة",
        "Languge": "اللغة",
        "Setting": "الأعدادات",
        "likes": "لايك",
        "View All comments": "مشاهدة كل التعليقات",
        "email": "الأيميل",
        "password": "كلمة السر",
        "Login": "تسجيل الدخول",
        "user name": "الأسم",
        "SignUp": "انشاء حساب",
        "SignIn": "تسجيل الدخول",
        "Logout": "تسجيل الخروج",
      }
    };
  }
}
