import 'package:ens_dart/ens_dart.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:poapin/common/constants.dart';
import 'package:poapin/data/models/account.dart';
import 'package:poapin/util/verification.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart';

abstract class BaseController extends GetxController {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final rpcUrl = 'https://mainnet.infura.io/v3/$infuraKey';
  final wsUrl = 'wss://mainnet.infura.io/ws/v3/$infuraKey';

  bool isSignedIn = false;

  String screenName();

  String ethAddress = '';
  String ensAddress = '';
  Account account = Account.empty();

  @override
  void onInit() {
    super.onInit();
    getAccount();
    if (screenName().isEmpty) {
      return;
    }
    analytics.setCurrentScreen(screenName: screenName());
  }

  void setPageTitle() {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: screenName(),
      primaryColor: Get.context!.theme.primaryColor.value,
    ));
  }

  void copy(String text) {
    Clipboard.setData(ClipboardData(
      text: text,
    )).then((value) => Get.snackbar('Copied!', '',
        messageText: Container(),
        duration: const Duration(seconds: 1),
        animationDuration: const Duration(milliseconds: 200),
        snackPosition: SnackPosition.BOTTOM));
  }

  void launchURL(String host, String path) async {
    if (!await launchUrl(Uri(host: host, path: path, scheme: 'https'),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $host';
    }
  }

  void launchDynamicURL(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  getAccount() {
    Box<Account> box = Hive.box(accountBox);
    if (box.values.isNotEmpty) {
      account = box.values.first;
      ethAddress = account.eth ?? '';
      ensAddress = account.ens ?? '';
      update();
    } else {
      account = Account.empty();
      ethAddress = '';
      ensAddress = '';
      update();
    }
  }

  late Ens ens;

  Future<bool> saveAccount(String address) async {
    if (VerificationHelper.isETH(address) ||
        VerificationHelper.isENS(address)) {
      final client = Web3Client(rpcUrl, Client(), socketConnector: () {
        return IOWebSocketChannel.connect(wsUrl).cast<String>();
      });
      ens = Ens(client: client);

      await VerificationHelper.getEthAndEns(ens, address).then((value) {
        List<String> ethAndEns = value;
        String eth = ethAndEns[0];
        String ens = ethAndEns[1];
        if (eth == '' && ens == '') {
          return;
        }
        if (eth.isNotEmpty) {
          ensAddress = ens;
          ethAddress = eth;
          update();
          Box<Account> box = Hive.box(accountBox);
          if (box.values.isNotEmpty) {
            String accountID = box.values.first.id;
            box.put(
              accountID,
              Account(
                id: accountID,
                eth: eth,
                ens: ens,
                addresses: box.values.first.addresses,
              ),
            );
          } else {
            box.put(
              eth,
              Account(
                id: eth,
                eth: eth,
                ens: ens,
                addresses: [],
              ),
            );
          }
          getAccount();
        }
      }).catchError((onError) {});
    }
    return Future.value(false);
  }

  setIsDispensed(String link) {
    getAccount();
    Box<Account> box = Hive.box(accountBox);
    if (box.values.isNotEmpty) {
      var acc = box.values.first;
      acc.isDispensed = true;
      acc.claimLink = link;
      box.put(acc.id, acc);
      getAccount();
      update();
    }
  }
}
