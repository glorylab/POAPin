import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/constants.dart';
import 'package:poapin/common/translations/locale_string.dart';
import 'package:poapin/common/routes/pages.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poapin/controllers/controller.user.dart';
import 'package:poapin/data/models/account.dart';
import 'package:poapin/data/models/address.dart';
import 'package:poapin/data/models/pref/layout.dart';
import 'package:poapin/data/models/pref/shape.dart';
import 'package:poapin/data/models/pref/sort.dart';
import 'package:poapin/data/models/pref/visibility.dart';
import 'package:poapin/data/models/tag.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/data/models/user.dart' as loca_user;
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/firebase_options.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/app/controller.dart';
import 'package:poapin/ui/pages/auth/controller.dart';
import 'package:poapin/ui/pages/collection/controller.dart';
import 'package:poapin/ui/pages/collection/controller.filter.dart';
import 'package:poapin/ui/pages/dashboard/binding.dart';
import 'package:poapin/ui/pages/home/controller.dart';
import 'package:poapin/ui/pages/home/controller.filter.dart';
import 'package:poapin/ui/pages/home/controllers/card.moment.dart';
import 'package:poapin/ui/pages/me/controller.dart';
import 'package:poapin/ui/pages/moment/controller.dart';
import 'package:poapin/ui/pages/moments/controller.dart';
import 'package:poapin/ui/pages/square/controller.dart';
import 'package:poapin/ui/pages/tags/controller.dart';
import 'package:poapin/ui/pages/watchlist/controller.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  setupAPI();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => MomentsCardController());
  Get.lazyPut(() => MomentsController());
  Get.lazyPut(() => MomentController());
  Get.lazyPut(() => CollectionController());
  Get.lazyPut(() => HomeFilterController());
  Get.lazyPut(() => FilterController());
  Get.lazyPut(() => WatchlistController());
  Get.lazyPut(() => MeController());
  Get.lazyPut(() => TagsController());
  Get.lazyPut(() => SquareController());
  Get.lazyPut(() => APPController());
  Get.lazyPut(() => UserController());
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(LayoutPrefAdapter());
  Hive.registerAdapter(ShapePrefAdapter());
  Hive.registerAdapter(SortPrefAdapter());
  Hive.registerAdapter(TokenAdapter());
  Hive.registerAdapter(EventAdapter());
  Hive.registerAdapter(SupplyAdapter());
  Hive.registerAdapter(TagAdapter());
  Hive.registerAdapter(VisibilityPrefAdapter());
  await Hive.openBox<Account>(accountBox);
  await Hive.openBox<Address>(addressBox);
  await Hive.openBox<Token>(poapBox);
  await Hive.openBox(prefBox);
  await Hive.openBox<Event>(eventBox);
  await Hive.openBox<Tag>(tagBox);
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    UserController c = Get.find<UserController>();

    if (user == null) {
      if (c.isSignedIn) {
        c.isSignedIn = false;
        c.user = loca_user.User.empty();
        c.update();
      }
    } else {
      if (c.isSignedIn) {
        return;
      } else {
        c.isSignedIn = true;
        c.update();
        c.getUserInfo();
      }
    }
  });
  FirebaseAuth.instance.idTokenChanges().listen((User? user) {
    if (user != null) {
      user.getIdToken(true).then((idToken) {
        UserController c = Get.find<UserController>();
        c.idToken = idToken;
      });
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }

      if (message.notification != null) {
        if (kDebugMode) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
        _handleForegroundMessage(message);
      }
    });
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    if (message.data['type'] == '10') {
      var rawData = message.data['data'];
      var rawObject = json.decode(rawData);
      if (rawObject != null && rawObject is List && rawObject.isNotEmpty) {
        Get.toNamed(
          '/square',
        );
      }
    }
    if (message.data['type'] == '20') {
      var rawData = message.data['data'];
      var rawObject = json.decode(rawData);
      if (rawObject != null && rawObject is List && rawObject.isNotEmpty) {}
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    if (message.data['type'] == '10') {
      var rawData = message.data['data'];
      var rawObject = json.decode(rawData);
      if (rawObject != null && rawObject is List && rawObject.isNotEmpty) {
        for (var event in rawObject) {
          if (event['id'] != null) {
          } else {}
        }
      }
    }
  }

  Locale _getLocale() {
    Box box = Hive.box(prefBox);
    var languagePref = box.get(prefLanguageKey);
    Locale locale = const Locale(
      'en',
      'US',
    );
    if (languagePref != null) {
      List localeString = languagePref.split('_');
      if (localeString.length == 2) {
        locale = Locale(localeString[0], localeString[1]);
      } else if (localeString.length == 1) {
        locale = Locale(localeString[0], '');
      }
    }
    return locale;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      initialBinding: DashboardBinding(),
      getPages: AppPages.routes,
      routingCallback: (routing) {},
      onInit: () {
        setupInteractedMessage();
      },
      unknownRoute: AppPages.unknownRoute,
      defaultTransition: kIsWeb ? Transition.topLevel : Transition.native,
      translations: LocaleString(), // Translations
      locale: _getLocale(), // translations will be displayed in that locale
      fallbackLocale: const Locale(
        'en',
        'US',
      ), // specify the fallback locale in case an invalid locale is selected.
      title: 'POAPin',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6534FF),
        backgroundColor: PColor.background,
        scaffoldBackgroundColor: PColor.background,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF8934),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: GoogleFonts.carterOne(),
          unselectedLabelStyle: GoogleFonts.carterOne(),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 16,
          shadowColor: Colors.black26,
          actionsIconTheme: IconThemeData(
            color: Color(0xFFFF8934),
          ),
        ),
      ),
    );
  }
}
