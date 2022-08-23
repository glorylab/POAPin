import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:poapin/common/constants.dart';
import 'package:poapin/common/translations/locale_string.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/data/models/account.dart';
import 'package:poapin/data/models/address.dart';
import 'package:poapin/data/models/tag.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/home/controller.dart';
import 'package:poapin/ui/pages/me/controller.dart';
import 'package:poapin/ui/pages/setting/components/dialog.languages.dart';
import 'package:poapin/ui/pages/watchlist/controller.dart';

class SettingController extends BaseController {
  String appName = 'POAPin';
  String packageName = '';
  String version = '';
  String buildNumber = '';
  bool isNotificationEventsEnabled = false;
  bool isNotificationFriendsEnabled = false;

  String locale = '';
  String languageName = '';

  void launchTwitter() {
    launchURL('https://twitter.com/glorylaboratory');
  }

  void launchMirror() {
    launchURL('https://mirror.xyz/glorylab.eth');
  }

  void launchGitHub() {
    launchURL('https://github.com/glorylab/POAPin');
  }

  void launchPOAPin() {
    launchURL('https://poap.in');
  }

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  String screenName() {
    return 'Setting';
  }

  void toggleEventNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    if (!isNotificationEventsEnabled) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        isNotificationEventsEnabled = true;
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        isNotificationEventsEnabled = true;
      } else {
        isNotificationEventsEnabled = true;
        Get.defaultDialog(
          radius: 24,
          titlePadding: const EdgeInsets.all(16),
          contentPadding: const EdgeInsets.all(16),
          title: 'Oops',
          content: const Text(
              'Already subscribed to event updates for you, but you may not have turned on the app\'s notification permissions.'),
        );
      }
      messaging.subscribeToTopic('events');
    } else {
      isNotificationEventsEnabled = false;
      messaging.unsubscribeFromTopic('events');
    }
    Hive.box(prefBox).put(prefEventNotifyKey, isNotificationEventsEnabled);
    update();
  }

  void toggleFriendNotification() async {
    isNotificationFriendsEnabled = !isNotificationFriendsEnabled;
    Hive.box(prefBox).put(prefFriendNotifyKey, isNotificationFriendsEnabled);
    update();
  }

  void showLanguageDialog() {
    Get.dialog(const LanguagesDialog());
  }

  setLanguage(String locale) {
    Hive.box(prefBox).put(prefLanguageKey, locale);
    if (locale != this.locale) {
      this.locale = locale;
      languageName = LocaleString().getLanguageName(locale);
      update();
      _updateLocale();
    }
  }

  _updateLocale() {
    List localeString = locale.split('_');
    if (localeString.length == 2) {
      Get.updateLocale(Locale(localeString[0], localeString[1]));
    } else if (localeString.length == 1) {
      Get.updateLocale(Locale(localeString[0], ''));
    }
  }

  _getLanguage() {
    Box box = Hive.box(prefBox);
    var languagePref = box.get(prefLanguageKey);
    if (languagePref != null) {
      locale = languagePref;
    } else {
      locale = LocaleString.defaultLocale;
    }
    languageName = LocaleString().getLanguageName(locale);
    update();
  }

  void clearAllCache() async {
    await Hive.box(prefBox).clear();
    await Hive.box<Account>(accountBox).clear();
    await Hive.box<Address>(addressBox).clear();
    await Hive.box<Token>(poapBox).clear();
    await Hive.box<Event>(eventBox).clear();
    await Hive.box<Tag>(tagBox).clear();
    Get.find<MeController>().getAccount();
    Get.find<HomeController>().getAccount();
    Get.find<WatchlistController>().getAccount();
    Get.defaultDialog(
        title: strDone,
        content: const Text(
            'Cache has been cleared.\nLet\'s start from the beginning!'),
        onConfirm: () {
          Get.back();
          Future.delayed(const Duration(milliseconds: 300)).then((value) {
            if (Get.previousRoute == '/setting') {
              Get.back();
            } else if (Get.previousRoute == '') {
              Get.offAndToNamed('/dashboard');
            } else {
              Get.until((route) => Get.currentRoute == '/dashboard');
            }
          });
        });
  }

  String getVersionString() {
    return '$appName $version ($buildNumber)';
  }

  void _checkIsEventsNotificationEnabled() {
    isNotificationEventsEnabled = false;
    Box box = Hive.box(prefBox);
    var eventNotifyPref = box.get(prefEventNotifyKey);
    if (eventNotifyPref != null) {
      isNotificationEventsEnabled = eventNotifyPref;
    } else {
      isNotificationEventsEnabled = false;
    }
    update();
  }

  void _checkIsFriendsNotificationEnabled() {
    isNotificationFriendsEnabled = false;
    Box box = Hive.box(prefBox);
    var friendNotifyPref = box.get(prefFriendNotifyKey);
    if (friendNotifyPref != null) {
      isNotificationFriendsEnabled = friendNotifyPref;
    } else {
      isNotificationFriendsEnabled = false;
    }
    update();
  }

  Future<void> _init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    update();
    _getLanguage();
    _checkIsEventsNotificationEnabled();
    _checkIsFriendsNotificationEnabled();
  }
}
