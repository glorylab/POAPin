import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/data/models/user.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/auth/controller.dart';
import 'package:poapin/ui/pages/home/controller.dart';
import 'package:poapin/ui/pages/me/controller.dart';

class UserController extends BaseController {
  List<String> eth = [];
  List<Membership> membership = [];
  String name = '';
  bool isGetingUserInfo = false;
  String idToken = '';
  User user = User.empty();

  void getUserInfo() async {
    isGetingUserInfo = true;
    update();
    idToken = await FirebaseAuth.instance.currentUser!.getIdToken(true);
    Get.lazyPut(() => AuthController());
    await Get.find<AuthController>().gm();
    try {
      var response = await Dio(
        BaseOptions(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
      ).get('https://api.poap.in/user/');
      user = User.fromJson(response.data['data']);
      isGetingUserInfo = false;
      if (user.eth.isNotEmpty) {
        await saveAccount(user.eth[0]);
      }
      update();
      Get.find<HomeController>().getAccount();
      Get.find<MeController>().getAccount();
    } on DioError catch (e) {
      isGetingUserInfo = false;
      Get.snackbar(strError, e.message);
      update();
      if (kDebugMode) {
        print(e);
      }
      if (e.response != null) {
        // if (e.response!.data != null && e.response!.data['message'] != null) {}
      } else {
        // Something happened in setting up or sending the request that triggered an Error

      }
    }
  }

  @override
  String screenName() {
    return '';
  }
}
