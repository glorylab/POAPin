import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:poapin/common/constants.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SquareController extends BaseController {
  ScrollController scrollController = ScrollController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  LoadingStatus status = LoadingStatus.loading;
  bool isNotificationEnabled = false;
  List<Event> events = [];
  String error = '';
  int cursor = 999999999;
  int size = 10;
  String sort = 'desc';
  bool isLoading = false;
  bool isNoticeRead = false;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(
      initialRefresh: false,
      initialRefreshStatus: RefreshStatus.idle,
    );
    _init();
    getData();
  }

  @override
  String screenName() {
    return 'Square';
  }

  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.decelerate);
    }
  }

  void _checkIsNotificationEnabled() {
    isNotificationEnabled = false;
    Box box = Hive.box(prefBox);
    var eventNotifyPref = box.get(prefEventNotifyKey);
    if (eventNotifyPref != null) {
      isNotificationEnabled = eventNotifyPref;
    } else {
      isNotificationEnabled = false;
    }
    update();
  }

  void _checkIsNoticeRead() {
    Box box = Hive.box(prefBox);
    isNoticeRead = box.get(prefSquareNoticeReadKey, defaultValue: false);
    update();
  }

  Future<void> _init() async {
    _checkIsNotificationEnabled();
    _checkIsNoticeRead();
  }

  void onRefresh() async {
    if (isLoading) return;
    cursor = 999999999;
    await getData();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    if (isLoading) return;
    await getData();
    refreshController.loadComplete();
  }

  void getCursor() {
    for (var event in events) {
      if (cursor > event.id) {
        cursor = event.id;
      }
    }
  }

  void markAsRead() {
    Hive.box(prefBox).put(prefSquareNoticeReadKey, true);
    _checkIsNoticeRead();
  }

  Future getData() async {
    isLoading = true;
    try {
      var response = await Dio().get(
          'https://api.poap.in/event?cursor=$cursor&size=$size&sort=$sort');
      isLoading = false;

      if (cursor == 999999999) {
        events.clear();
      }
      error = '';
      var _res = response.data;

      if (_res['code'] == 0) {
        _res['data'].forEach((event) {
          events.add(Event.fromJson(event));
        });
      }

      status = LoadingStatus.loaded;
      update();
      getCursor();
      return;
    } on DioError catch (e) {
      isLoading = false;
      if (e.response != null) {
        if (e.response!.data != null && e.response!.data['message'] != null) {
          status = LoadingStatus.failed;
          error = e.response!.data['message'];
        }
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        error = 'Oops, something went wrong';
        status = LoadingStatus.loaded;
      }
      update();
      return;
    }
  }
}
