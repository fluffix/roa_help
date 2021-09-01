import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roa_help/Controllers/GeneralController.dart';
import 'package:roa_help/Requests/Auth/Auth.dart';
import 'package:roa_help/Requests/Profile/Profile.dart';
import 'package:roa_help/Requests/Profile/ProfileSetialise.dart';
import 'package:roa_help/Requests/Stats/Stats.dart';
import 'package:roa_help/Requests/Stats/StatsSerialise.dart';
import 'package:roa_help/Utils/Routes/Routes.dart';

class AuthController {
  AuthController({
    @required this.controller,
  });
  final GeneralController controller;

  authLogin(
      {@required BuildContext context,
      @required TextEditingController usernameController,
      @required TextEditingController passwordController}) async {
    int statusCode = await authRequest(
        userName: usernameController.text, password: passwordController.text);
    switch (statusCode) {
      case 201:
        StatsSerialise stats = await getStats();
        ProfileInfoSerialise profileInfo = await getProfile();
        await controller.waterController.setDayNorm(
            waterDayNorm: profileInfo.waterDayNorm, startAnimation: true);
        await controller.waterController.setWasDrinked(wasDrinked: stats.water);
        await controller.notificationsController.getSavedNotifications();
        Navigator.pushNamed(context, Routes.home);
        break;
      case 403:
        exceptionToast('Username or password not correct');
        break;
    }
  }

  authRegistration({
    @required BuildContext context,
    @required TextEditingController usernameController,
    @required TextEditingController passwordController,
    @required TextEditingController confirmPasswordController,
    @required String chosenCity,
  }) async {
    if (usernameController.text.isEmpty) {
      exceptionToast('empty username');
    } else if (passwordController.text.length < 8) {
      exceptionToast('password unsafe');
    } else if (passwordController.text != confirmPasswordController.text) {
      exceptionToast('passwords differ');
    } else {
      int statusCode = await regRequest(
        userName: usernameController.text,
        password: passwordController.text,
        extra: chosenCity != null
            ? {
                "city": '$chosenCity',
                "waterDayNorm": 8,
              }
            : {"waterDayNorm": 8},
      );
      switch (statusCode) {
        case 200:
          StatsSerialise stats = await getStats();
          ProfileInfoSerialise profileInfo = await getProfile();
          await controller.waterController.setDayNorm(
              waterDayNorm: profileInfo.waterDayNorm, startAnimation: true);
          await controller.waterController
              .setWasDrinked(wasDrinked: stats.water);
          await controller.notificationsController.getSavedNotifications();
          Navigator.pushNamed(context, '/home');
          break;
        case 422:
          exceptionToast('The username has already been taken');
          break;
      }
    }
  }
}

Future<bool> exceptionToast(String toastText) {
  return Fluttertoast.showToast(
      msg: "$toastText",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: Colors.red,
      backgroundColor: Colors.green,
      fontSize: 16.0);
}
