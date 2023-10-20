import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/util/verification.dart';

class WatchlistController extends BaseController {
  ScrollController scrollController = ScrollController();
  int lastMilli = DateTime.now().millisecondsSinceEpoch;
  double velocity = 0;
  double lastVelocity = 0;
  double scrollDelta = 0;
  double lastOffset = 0;
  final double hideVelocity = 2;

  final count = 0.obs;
  final uniqueCount = 0.obs;
  final error = ''.obs;
  final RxList<Token> tokens = <Token>[].obs;
  LoadingStatus loadingStatus = LoadingStatus.waiting;
  Map filteredTokens = {
    0: {0: <Token>[]}
  };
  Map filteredTokensWithDay = {
    0: {
      0: {0: <Token>[]}
    }
  };

  @override
  String screenName() {
    return 'Watchlist';
  }

  String address = '';
  bool isTimelineLayout = false;

  final addressController = TextEditingController();

  @override
  void onInit() {
    addressController.text = '';
    super.onInit();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        final now = DateTime.now();
        final timeDiff = now.millisecondsSinceEpoch - lastMilli;

        if (timeDiff < 200) {
          return;
        } else {
          lastMilli = now.millisecondsSinceEpoch;
        }
        scrollDelta = (scrollController.offset - lastOffset).abs();
        lastOffset = scrollController.offset;

        if (scrollDelta == 0) {
          velocity = 0;
        } else {
          if (timeDiff == 0) {
            return;
          } else {
            velocity = scrollDelta / timeDiff;
          }
        }

        update();
        lastVelocity = velocity;
      });

      if (scrollController.hasClients) {
        scrollController.position.isScrollingNotifier.addListener(() {
          if (!scrollController.position.isScrollingNotifier.value) {
            velocity = 0;
            update();
          } else {}
        });
      }
    });
  }

  @override
  void onClose() {
    addressController.dispose();
    super.onClose();
  }

  void toggleLayout() {
    isTimelineLayout = !isTimelineLayout;
    update();
  }

  void onSubmit() async {
    Get.back();
    if (addressController.text.isNotEmpty) {
      if (VerificationHelper.isETH(addressController.text.trim()) ||
          VerificationHelper.isENS(addressController.text.trim())) {
        address = addressController.text.trim().toLowerCase();
        update();
        await Get.toNamed('/scan/$address')?.then((value) {
          getAccount();
          addressController.clear();
          getData();
        });
      } else {
        Get.snackbar(strError, strInvalidAddress,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade300,
            animationDuration: const Duration(milliseconds: 200),
            duration: const Duration(seconds: 1),
            colorText: Colors.white,
            borderRadius: 8,
            margin: const EdgeInsets.all(8),
            overlayBlur: 8,
            snackStyle: SnackStyle.FLOATING);
      }
    }
  }

  String? validator(String value) {
    if (value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  updateAddress(String address) {
    this.address = address;
    update();
  }

  void _updateStatus() {
    count.value = tokens.length;
  }

  void _updateLoadingStatus(LoadingStatus s) {
    loadingStatus = s;
    update();
  }

  void sortData() {
    List<Token> rawTokensDataSortByTime = [];
    rawTokensDataSortByTime = tokens;
    rawTokensDataSortByTime.sort((a, b) {
      if (a.event.startDate != null && b.event.endDate != null) {
        return b.event.startDate!.compareTo(a.event.startDate!);
      }
      return a.tokenId.compareTo(b.tokenId);
    });
    Map<int, Map<int, Map<int, List<Token>>>> tokensByYearAndMonthAndDay = {};
    Map<int, Map<int, List<Token>>> tokensByYearAndMonth = {};
    for (var token in rawTokensDataSortByTime) {
      token.event.realYear = token.event.startDate!.year;
      token.event.month = token.event.startDate!.month;
      token.event.day = token.event.startDate!.day;

      if (tokensByYearAndMonthAndDay[token.event.realYear] == null) {
        tokensByYearAndMonthAndDay[token.event.realYear] = {};
      }
      if (tokensByYearAndMonthAndDay[token.event.realYear]![
              token.event.month] ==
          null) {
        tokensByYearAndMonthAndDay[token.event.realYear]![token.event.month] =
            {};
      }
      if (tokensByYearAndMonthAndDay[token.event.realYear]![token.event.month]![
              token.event.day] ==
          null) {
        tokensByYearAndMonthAndDay[token.event.realYear]![token.event.month]![
            token.event.day] = [];
      }
      tokensByYearAndMonthAndDay[token.event.realYear]?[token.event.month]
              ?[token.event.day]
          ?.add(token);
      if (tokensByYearAndMonth[token.event.realYear] == null) {
        tokensByYearAndMonth[token.event.realYear] = {};
      }
      if (tokensByYearAndMonth[token.event.realYear]![token.event.month] ==
          null) {
        tokensByYearAndMonth[token.event.realYear]![token.event.month] = [];
      }
      tokensByYearAndMonth[token.event.realYear]?[token.event.month]
          ?.add(token);
    }
    filteredTokensWithDay = tokensByYearAndMonthAndDay;
    filteredTokens = tokensByYearAndMonth;
    update();
  }

  void getData() async {
    _updateLoadingStatus(LoadingStatus.loading);
    tokens.clear();
    for (var addr in account.addresses) {
      List<Token> tokens = await getTokens(addr.address) ?? [];
      tokens.addAll(tokens);
    }
    _updateLoadingStatus(LoadingStatus.loaded);
    _updateStatus();
    sortData();
  }

  Future getTokens(String eth) async {
    try {
      var response = await Dio().get('https://api.poap.tech/actions/scan/$eth');
      List data = response.data;
      List tokens = data.map((t) => Token.fromJson(t)).toList();
      return tokens;
    } on DioException catch (_) {
      return null;
    }
  }

  String getMonthString(int month) {
    switch (month) {
      case 1:
        return strJanuary;
      case 2:
        return strFebruary;
      case 3:
        return strMarch;
      case 4:
        return strApril;
      case 5:
        return strMay;
      case 6:
        return strJune;
      case 7:
        return strJuly;
      case 8:
        return strAugust;
      case 9:
        return strSeptember;
      case 10:
        return strOctober;
      case 11:
        return strNovember;
      case 12:
        return strDecember;
      default:
        return '-';
    }
  }
}
