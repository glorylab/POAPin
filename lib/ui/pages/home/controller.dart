import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/controllers/tag.dart';
import 'package:poapin/data/models/gitpoap.dart';
import 'package:poapin/data/models/moment.dart';
import 'package:poapin/data/models/pref/visibility.dart';
import 'package:poapin/data/models/tag.dart';
import 'package:poapin/data/repository/gitpoap_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/secrets.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:dio/dio.dart';
import 'package:ens_dart/ens_dart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';
import 'package:poapin/common/constants.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/data/models/address.dart';
import 'package:poapin/data/models/pref/layout.dart';
import 'package:poapin/data/models/pref/shape.dart';
import 'package:poapin/data/models/pref/sort.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/ui/pages/detail/dialog/addtag.dart';
import 'package:poapin/ui/pages/home/components/dialog.gitpoap.dart';
import 'package:poapin/ui/pages/home/controllers/card.moment.dart';
import 'package:poapin/util/verification.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart';

class HomeController extends BaseController {
  ScrollController scrollController = ScrollController();
  int lastMilli = DateTime.now().millisecondsSinceEpoch;
  int lastStickyMilli = DateTime.now().millisecondsSinceEpoch;
  double velocity = 0;
  double lastVelocity = 0;
  double scrollDelta = 0;
  double lastOffset = 0;
  final double hideVelocity = 2;

  final gitPOAPRepository = getIt.get<GitPOAPRepository>();

  @override
  String screenName() {
    return 'Home';
  }

  bool isWebOption = false;
  bool isWebOptionHover = false;

  setIsWebOptionHover(bool isHover) {
    isWebOptionHover = isHover;
    update();
  }

  bool isEditMode = false;
  List<Token> selectedTokens = <Token>[];

  Map filters = {};

  int poapCount = 0;
  int eventCount = 0;
  int filteredPOAPCount = 0;
  int filteredEventsCount = 0;
  List<Token> tokens = <Token>[];
  Map filteredTokens = {
    0: {0: <Token>[]}
  };
  Map filteredTokensWithDay = {
    0: {
      0: {0: <Token>[]}
    }
  };

  bool isLoadingGitPOAPs = true;
  List<GitPOAP> gitPOAPs = <GitPOAP>[];
  int gitPOAPCount = 0;

  /// Counts the number of POAPs at each event.
  Map eventCounts = {};

  String chartView = 'growth';
  List<FlSpot> growthTokenSpots = <FlSpot>[];
  List<FlSpot> monthlyTokenSpots = <FlSpot>[];
  int maxTokensInGrowthView = 0;
  int maxTokensInMonthlyView = 0;
  int maxXLine = 0;
  Map<DateTime, int> heatmapDataset = {};

  final countries = {}.obs;
  Map tags = {};
  final layers = {}.obs;
  Map chains = {};

  final isFavorite = false.obs;
  LoadingStatus loadingStatus = LoadingStatus.waiting;
  CacheLoadingStatus cacheLoadingStatus = CacheLoadingStatus.loading;

  String accountID = '';

  final error = ''.obs;

  void launchGitPOAP() {
    launchURL('https://www.gitpoap.io');
  }

  void launchPOAPinGithub() {
    launchURL('https://github.com/glorylab/POAPin');
  }

  void showGitPOAPDialog() {
    Get.dialog(const GitPOAPDialog());
  }

  /// config
  VisibilityPref visibility = VisibilityPref.hideDuplicates;
  SortPref sortBy = SortPref.timeAsc;
  ShapePref shape = ShapePref.round;
  LayoutPref layout = LayoutPref.grid;

  getPrefs() {
    Box box = Hive.box(prefBox);
    var layoutPref = box.get(prefLayoutKey);
    if (layoutPref != null) {
      layout = layoutPref;
    } else {
      layout = LayoutPref.grid;
    }

    var shapePref = box.get(prefShapeKey);
    if (shapePref != null) {
      shape = shapePref;
    } else {
      shape = ShapePref.round;
    }

    var sortPref = box.get(prefSortKey);
    if (sortPref != null) {
      sortBy = sortPref;
    } else {
      sortBy = SortPref.timeAsc;
    }
  }

  _getCachedEns() {
    if (account.eth != null) {
      final String _address = account.eth ?? '';
      Box<Address> box = Hive.box(addressBox);
      Address cachedAddress;
      if (box.values.isNotEmpty) {
        cachedAddress = box.values.firstWhere(
          (addr) => addr.address == _address || addr.ens == _address,
          orElse: () => Address('', '', DateTime.now()),
        );
        if (cachedAddress.address == '') {
          ethAddress = _address;
          update();
          return;
        }
        ensAddress = cachedAddress.ens;
        ethAddress = cachedAddress.address;
        update();
        return;
      } else {
        ethAddress = _address;
        update();
      }
    }
  }

  bool isSelected(Token t) {
    return selectedTokens.contains(t);
  }

  void clearSelectedTokens() {
    selectedTokens.clear();
  }

  setSelectedToken(Token t) {
    if (selectedTokens.isEmpty) {
      selectedTokens = [t];
    } else {
      bool alreadySelected = false;
      for (var token in selectedTokens) {
        if (t.tokenId == token.tokenId) {
          alreadySelected = true;
        }
      }
      if (alreadySelected) {
        selectedTokens.remove(t);
      } else {
        selectedTokens.add(t);
      }
    }
    update();
  }

  setIsEditMode(isEditMode) {
    this.isEditMode = isEditMode;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    poapCount = 0;
    eventCount = 0;
    filteredPOAPCount = 0;
    filteredEventsCount = 0;
    tokens = [];
    getPrefs();
    _getCachedEns();
    _initEns();
    getCachedData();
    getData();
    getMoments();
    getGitPOAPs();
    _initWebMessage();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.hasClients) {
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

        scrollController.position.isScrollingNotifier.addListener(() {
          if (!scrollController.position.isScrollingNotifier.value) {
            velocity = 0;
            update();
          } else {}
        });
      }
    });
  }

  _initWebMessage() async {
    if (GetPlatform.isWeb) {
      // use the returned token to send messages to users from your custom server
      await messaging.getToken(
        vapidKey: Secrets.fcmVapidKEY,
      );
    }
  }

  _initEns() {
    final client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });
    ens = Ens(client: client);

    final parameters = Get.parameters;
    final String _address = parameters['address'].toString();
    VerificationHelper.getEthAndEns(ens, _address).then((value) {
      List<String> ethAndEns = value;
      String eth = ethAndEns[0];
      String ens = ethAndEns[1];
      if (eth == '' && ens == '') {
        return;
      }
      if (ens.isNotEmpty) {
        ensAddress = ens;
        ethAddress = eth;
        update();
        Box<Address> box = Hive.box(addressBox);
        box.put(eth, Address(eth, ens, DateTime.now()));
      }
    });
  }

  _setFilter(String key, dynamic value) {
    filters[key] = value;
    update();
    filter();
  }

  _clearFilter(String key) {
    filters.remove(key);
    update();
    filter();
  }

  setFilterByTag(Tag tag) {
    _setFilter('tag', tag);
  }

  clearTagFilter() {
    _clearFilter('tag');
  }

  setFilterByCountry(String country) {
    _setFilter('country', country);
  }

  clearCountryFilter() {
    _clearFilter('country');
  }

  setFilterByTitle(String title) {
    _setFilter('title', title);
  }

  clearTitleFilter() {
    _clearFilter('title');
  }

  setFilterByDesc(String desc) {
    _setFilter('description', desc);
  }

  clearDescFilter() {
    _clearFilter('description');
  }

  setFilterByChain(String chain) {
    _setFilter('chain', chain);
  }

  clearChainFilter() {
    _clearFilter('chain');
  }

  clearFilters() {
    filters = {};
    update();
    filter();
  }

  setVisibility(VisibilityPref visibility) {
    Hive.box(prefBox).put(prefVisibilityKey, visibility);
    if (visibility != this.visibility) {
      this.visibility = visibility;
      update();
      filter();
    }
  }

  setShape(ShapePref shape) {
    Hive.box(prefBox).put(prefShapeKey, shape);
    if (shape != this.shape) {
      this.shape = shape;
      update();
    }
  }

  setSortBy(SortPref sortBy) {
    Hive.box(prefBox).put(prefSortKey, sortBy);
    if (sortBy != this.sortBy) {
      this.sortBy = sortBy;
      update();
      filter();
    }
  }

  setLayout(LayoutPref layout) {
    Hive.box(prefBox).put(prefLayoutKey, layout);
    if (layout != this.layout) {
      this.layout = layout;
      update();
      if (layout == LayoutPref.timeline) {
        filter();
      }
    }
  }

  updateEthAddress(String address) {
    if (address != ethAddress) {
      ethAddress = address;
      update();
    }
  }

  void _clearCountries() {
    countries.value = {};
  }

  void _getCountries(String? country) {
    if (country != null && country.isNotEmpty) {
      countries.value[country] = (countries.value[country] ?? 0) + 1;
    }
  }

  void _clearTags() {
    tags = {};
    update();
  }

  void _getTags(List<Tag>? tags) {
    if (tags != null && tags.isNotEmpty) {
      for (var t in tags) {
        var key = t.id;
        var value = this.tags[t.id];
        if (t.name.isNotEmpty) {
          var count = 0;
          if (value != null) {
            count = value[t] ?? 0;
          } else {
            count = 0;
          }

          value = {
            t: count + 1,
          };
        }
        this.tags[key] = value;
      }
      update();
    }
  }

  void sortCountries() {
    var sortedEntries = countries.value.entries.toList()
      ..sort((e1, e2) {
        var diff = e2.value.compareTo(e1.value);
        if (diff == 0) diff = e1.key.compareTo(e2.key);
        return diff;
      });
    countries.value
      ..clear()
      ..addEntries(sortedEntries);
  }

  void _clearChains() {
    chains = {};
    update();
  }

  void _getChains(String? chain) {
    if (chain != null && chain.isNotEmpty) {
      chains[chain] = (chains[chain] ?? 0) + 1;
      update();
    }
  }

  void sortChains() {
    var sortedEntries = chains.entries.toList()
      ..sort((e1, e2) {
        var diff = e2.value.compareTo(e1.value);
        if (diff == 0) diff = e1.key.compareTo(e2.key);
        return diff;
      });
    chains
      ..clear()
      ..addEntries(sortedEntries);
    update();
  }

  void _clearLayers() {}

  void _getLayers(String? layer) {}

  void sortLayers() {}

  void refreshTags() {
    _refreshTags(tokens);
  }

  void _refreshTags(List<Token> tokens) {
    _clearTags();
    Box _eventsBox = Hive.box<Event>(eventBox);
    for (var d in tokens) {
      Event _newEvent = _eventsBox.get(d.event.id, defaultValue: Event.empty());
      if (_newEvent.id > 0) {
        d.event.tags = _newEvent.tags;

        _getTags(d.event.tags);
      }
    }
    this.tokens = tokens;
    update();
  }

  void filter() {
    _clearCountries();
    _clearTags();
    _clearLayers();
    _clearChains();
    List<Token> rawTokensDataSortByTime = [];
    List<int> uniqueEventIDList = [];
    List<int> filteredUniqueEventIDList = [];
    filteredPOAPCount = 0;

    rawTokensDataSortByTime = tokens;

    /// Sort by time
    rawTokensDataSortByTime.sort((a, b) {
      if (a.event.startDate != null && b.event.endDate != null) {
        if (sortBy == SortPref.timeAsc) {
          return b.event.startDate!.compareTo(a.event.startDate!);
        }
        return a.event.startDate!.compareTo(b.event.startDate!);
      }
      return a.tokenId.compareTo(b.tokenId);
    });
    Map<int, Map<int, List<Token>>> tokensByYearAndMonth = {};
    Map<int, Map<int, Map<int, List<Token>>>> tokensByYearAndMonthAndDay = {};

    /// The data must be divided into daily segments for the timeline layout.
    if (layout != LayoutPref.timeline) {
      for (var token in rawTokensDataSortByTime) {
        if (visibility == VisibilityPref.hideDuplicates) {
          if (uniqueEventIDList.contains(token.event.id)) {
            continue;
          }
        }

        /// Counts the number of POAPs at each event.
        if (!uniqueEventIDList.contains(token.event.id)) {
          uniqueEventIDList.add(token.event.id);
          eventCounts[token.event.id] = 1;
        } else {
          eventCounts[token.event.id] = eventCounts[token.event.id] + 1;
        }

        _getCountries(token.event.country);
        _getTags(token.event.tags);
        _getLayers(token.layer);
        _getChains(token.chain);
        if (filters['chain'] != null && filters['chain'] != '') {
          if (token.chain != filters['chain']) {
            continue;
          }
        }
        if (filters['country'] != null && filters['country'] != '') {
          if (token.event.country != filters['country']) {
            continue;
          }
        }
        if (filters['tag'] != null && filters['tag'] != '') {
          bool tagFound = false;

          token.event.tags?.forEach((t) {
            if (t.id == filters['tag'].id) {
              tagFound = true;
            }
          });
          if (!tagFound) {
            continue;
          }
        }
        if (filters['title'] != null && filters['title'] != '') {
          if (!token.event.name
              .toLowerCase()
              .contains(filters['title'].toLowerCase())) {
            continue;
          }
        }
        if (filters['description'] != null && filters['description'] != '') {
          if (!token.event.description
              .toLowerCase()
              .contains(filters['description'].toLowerCase())) {
            continue;
          }
        }
        token.event.realYear = token.event.startDate!.year;
        token.event.month = token.event.startDate!.month;
        token.event.day = token.event.startDate!.day;

        if (tokensByYearAndMonth[token.event.realYear] == null) {
          tokensByYearAndMonth[token.event.realYear] = {};
        }
        if (tokensByYearAndMonth[token.event.realYear]![token.event.month] ==
            null) {
          tokensByYearAndMonth[token.event.realYear]![token.event.month] = [];
        }
        tokensByYearAndMonth[token.event.realYear]?[token.event.month]
            ?.add(token);

        if (!filteredUniqueEventIDList.contains(token.event.id)) {
          filteredUniqueEventIDList.add(token.event.id);
        }
        filteredPOAPCount = filteredPOAPCount + 1;
      }
    } else {
      for (var token in rawTokensDataSortByTime) {
        if (visibility == VisibilityPref.hideDuplicates) {
          if (uniqueEventIDList.contains(token.event.id)) {
            continue;
          }
        }

        /// Counts the number of POAPs at each event.
        if (!uniqueEventIDList.contains(token.event.id)) {
          uniqueEventIDList.add(token.event.id);
          eventCounts[token.event.id] = 1;
        } else {
          eventCounts[token.event.id] = eventCounts[token.event.id] + 1;
        }

        _getCountries(token.event.country);
        _getTags(token.event.tags);
        _getLayers(token.layer);
        _getChains(token.chain);
        if (filters['chain'] != null && filters['chain'] != '') {
          if (token.chain != filters['chain']) {
            continue;
          }
        }
        if (filters['country'] != null && filters['country'] != '') {
          if (token.event.country != filters['country']) {
            continue;
          }
        }
        if (filters['tag'] != null && filters['tag'] != '') {
          bool tagFound = false;
          token.event.tags?.forEach((t) {
            if (t.id == filters['tag'].id) {
              tagFound = true;
            }
          });
          if (!tagFound) {
            continue;
          }
        }
        if (filters['title'] != null && filters['title'] != '') {
          if (!token.event.name
              .toLowerCase()
              .contains(filters['title'].toLowerCase())) {
            continue;
          }
        }
        if (filters['description'] != null && filters['description'] != '') {
          if (!token.event.description
              .toLowerCase()
              .contains(filters['desc'].toLowerCase())) {
            continue;
          }
        }
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
        if (tokensByYearAndMonthAndDay[token.event.realYear]![
                token.event.month]![token.event.day] ==
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

        if (!filteredUniqueEventIDList.contains(token.event.id)) {
          filteredUniqueEventIDList.add(token.event.id);
        }
        filteredPOAPCount = filteredPOAPCount + 1;
      }
    }

    eventCount = uniqueEventIDList.length;
    filteredEventsCount = filteredUniqueEventIDList.length;

    filteredTokensWithDay = tokensByYearAndMonthAndDay;
    filteredTokens = tokensByYearAndMonth;

    update();

    _generateTokenSpots();
    sortCountries();
    sortLayers();
    sortChains();
  }

  toggleChartView() {
    if (chartView == 'growth') {
      chartView = 'monthly';
    } else if (chartView == 'monthly') {
      chartView = 'heatmap';
    } else {
      chartView = 'growth';
    }
    update();
  }

  _generateTokenSpots() {
    List<Token> rawTokensDataSortByTime = [];

    rawTokensDataSortByTime = tokens;

    /// Sort by time
    rawTokensDataSortByTime.sort((a, b) {
      if (a.event.startDate != null && b.event.endDate != null) {
        return a.event.startDate!.compareTo(b.event.startDate!);
      }

      return a.tokenId.compareTo(b.tokenId);
    });

    Map<int, Map<int, List<Token>>> tokensByYearAndMonth = {};
    for (var token in rawTokensDataSortByTime) {
      token.event.realYear = token.event.startDate!.year;
      token.event.month = token.event.startDate!.month;
      token.event.day = token.event.startDate!.day;

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

    Map _tokenMap = tokensByYearAndMonth;

    int lastYear = 0;
    int lastMonth = 0;
    List<FlSpot> _tempGrown = [];
    List<FlSpot> _tempMonth = [];
    int _maxGrowth = 0;
    int _maxMonth = 0;

    double x = 0, y = 0, splitY = 0;
    heatmapDataset = {};
    _tokenMap.forEach((year, tokensInMonth) {
      tokensInMonth.forEach((month, tokens) {
        if (year > DateTime.now().year) {
          return;
        }
        if (year == DateTime.now().year && month > DateTime.now().month) {
          return;
        }

        if (lastYear == 0) {
          x = 0;
        } else {
          if (lastYear == year) {
            x = x + (month - lastMonth).abs();
          } else {
            if ((year - lastYear).abs() == 1) {
              x = x + (12 - lastMonth).abs() + month.abs();
            } else {
              x = x +
                  (12 - lastMonth).abs() +
                  month.abs() +
                  (year - lastYear).abs() * 12;
            }
          }
        }

        lastYear = year;
        lastMonth = month;

        splitY = tokens.length.toDouble();

        _tempMonth.add(FlSpot(x, splitY));

        y = tokens.length + y;

        _tempGrown.add(FlSpot(x, y));

        if (_maxMonth < splitY) {
          _maxMonth = splitY.toInt();
        }

        _maxGrowth = tokens.length + _maxGrowth;

        tokens.forEach((Token token) {
          heatmapDataset[token.event.startDate!] =
              (heatmapDataset[token.event.startDate] ?? 0) + 1;
        });
      });
    });
    growthTokenSpots = _tempGrown;
    monthlyTokenSpots = _tempMonth;
    maxTokensInGrowthView = _maxGrowth;
    maxTokensInMonthlyView = _maxMonth;

    maxXLine = x.toInt();
    update();
  }

  final TextEditingController textEditController = TextEditingController();

  void editTag() {
    List<Event> _events = [];
    if (tokens.isNotEmpty) {
      for (var t in selectedTokens) {
        if (!_events.contains(t.event)) {
          _events.add(t.event);
        }
      }
    }
    Get.find<TagController>().refreshTag(_events.map((e) => e.id).toList());
    Get.dialog(
      AddTagDialog(
        events: _events,
        textEditController: textEditController,
      ),
    );
  }

  void hidePOAPs() {}

  void getCachedData() {
    Box<Token> box = Hive.box(poapBox);
    var allCachedData = box.values;

    List<Token> cachedData = allCachedData.where((token) {
      return token.owner.toLowerCase() == ethAddress.toLowerCase();
    }).toList();

    if (cachedData.isNotEmpty) {
      _refreshTags(cachedData);
      _updateStatus();
    }
    cacheLoadingStatus = CacheLoadingStatus.loaded;
    update();
  }

  void clearCachedData() {
    Hive.box<Token>(poapBox).clear();
  }

  void cacheData() {
    if (tokens.length > 1000) {
      return;
    }
    Box<Token> box = Hive.box(poapBox);

    for (var token in tokens) {
      box.put(token.tokenId, token);
    }
  }

  void _updateStatus() {
    poapCount = tokens.length;
    filteredPOAPCount = poapCount;
    update();
    filter();
  }

  void _updateLoadingStatus(LoadingStatus s) {
    loadingStatus = s;
    update();
  }

  void getMoments() {
    Get.find<MomentsCardController>().getFirstMoment(ethAddress);
  }

  void getGitPOAPs() {
    isLoadingGitPOAPs = true;
    update();

    gitPOAPRepository.scan(ethAddress).then((response) {
      isLoadingGitPOAPs = false;
      gitPOAPs = response;
      gitPOAPCount = gitPOAPs.length;
      update();
    });
  }

  void getData() async {
    if (cacheLoadingStatus == CacheLoadingStatus.loaded) {
      if (poapCount == 0) {
        poapCount = 0;
        eventCount = 0;
        filteredPOAPCount = 0;
        filteredEventsCount = 0;
        tokens = [];
        filteredTokens = {};
        filteredTokensWithDay = {};
        update();
      }
    }

    error.value = '';
    cacheLoadingStatus = CacheLoadingStatus.loaded;
    update();
    _updateLoadingStatus(LoadingStatus.loading);
    if (ethAddress == '') {
      return;
    }
    try {
      var response =
          await Dio().get('https://api.poap.tech/actions/scan/$ethAddress');
      error.value = '';
      List _tokens = response.data;
      List<Token> originData = _tokens.map((t) => Token.fromJson(t)).toList();
      _refreshTags(originData);
      _updateLoadingStatus(LoadingStatus.loaded);
      _updateStatus();
      clearCachedData();
      cacheData();
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data != null && e.response!.data['message'] != null) {
          error.value = e.response!.data['message'];
          _updateLoadingStatus(LoadingStatus.failed);
        }
      } else {
        if (e.error != 'XMLHttpRequest error.') {
          error.value = 'Oops, something went wrong';
        }
        error.value = '';
        _updateLoadingStatus(LoadingStatus.failed);
        // Something happened in setting up or sending the request that triggered an Error
      }
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
