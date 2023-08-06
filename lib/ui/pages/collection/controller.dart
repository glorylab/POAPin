import 'package:ens_dart/ens_dart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:poapin/common/constants.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/data/models/account.dart';
import 'package:poapin/data/models/address.dart';
import 'package:poapin/data/models/pref/layout.dart';
import 'package:poapin/data/models/pref/shape.dart';
import 'package:poapin/data/models/pref/sort.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/data/repository/poap_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/util/verification.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart';

class CollectionController extends BaseController {
  @override
  String screenName() {
    return 'Collection List';
  }

  final filters = {}.obs;
  final count = 0.obs;
  final uniqueCount = 0.obs;
  final RxList<Token> tokens = <Token>[].obs;
  final filteredTokens = {
    0: {0: <Token>[]}
  }.obs;
  final filteredTokensWithDay = {
    0: {
      0: {0: <Token>[]}
    }
  }.obs;

  final chartView = 'growth'.obs;
  final growthTokenSpots = <FlSpot>[].obs;
  final monthlyTokenSpots = <FlSpot>[].obs;
  final maxTokensInGrowthView = 0.obs;
  final maxTokensInMonthlyView = 0.obs;
  final maxXLine = 0.obs;

  final countries = {}.obs;
  final layers = {}.obs;

  bool isFavorite = false;
  LoadingStatus loadingStatus = LoadingStatus.waiting;
  CacheLoadingStatus cacheLoadingStatus = CacheLoadingStatus.loading;

  String accountID = '';

  final error = ''.obs;

  /// config
  final sortBy = SortPref.timeAsc.obs;
  final shape = ShapePref.round.obs;
  final layout = LayoutPref.grid.obs;

  getPrefs() {
    Box box = Hive.box(prefBox);
    var layoutPref = box.get(prefLayoutKey);
    if (layoutPref != null) {
      layout.value = layoutPref;
    } else {
      layout.value = LayoutPref.grid;
    }

    var shapePref = box.get(prefShapeKey);
    if (shapePref != null) {
      shape.value = shapePref;
    } else {
      shape.value = ShapePref.round;
    }

    var sortPref = box.get(prefSortKey);
    if (sortPref != null) {
      sortBy.value = sortPref;
    } else {
      sortBy.value = SortPref.timeAsc;
    }
  }

  _getCachedEns() {
    final parameters = Get.parameters;
    final String address = parameters['address'].toString();
    Box<Address> box = Hive.box(addressBox);
    Address cachedAddress;
    if (box.values.isNotEmpty) {
      cachedAddress = box.values.firstWhere(
        (addr) => addr.address == address || addr.ens == address,
        orElse: () => Address('', '', DateTime.now()),
      );
      if (cachedAddress.address == '') {
        ethAddress = address;
        update();
        return;
      }
      ensAddress = cachedAddress.ens;
      ethAddress = cachedAddress.address;
      update();
      return;
    } else {
      ethAddress = address;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    count.value = 0;
    uniqueCount.value = 0;
    tokens.value = [];
    getPrefs();
    _getCachedEns();
    _initEns();
    checkIfFavorite();
    getCachedData();
    getData();
  }

  _initEns() {
    final client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });
    ens = Ens(client: client);

    final parameters = Get.parameters;
    final String address = parameters['address'].toString();
    VerificationHelper.getEthAndEns(ens, address).then((value) {
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

  _setFilter(String key, String value) {
    filters.value[key] = value;
    filter();
  }

  _clearFilter(String key) {
    filters.value.remove(key);
    filter();
  }

  setFilterByCountry(String country) {
    _setFilter('country', country);
  }

  clearCountryFilter() {
    _clearFilter('country');
  }

  setFilterByLayer(String country) {
    _setFilter('layer', country);
  }

  clearLayerFilter() {
    _clearFilter('layer');
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

  clearFilters() {
    filters.value = {};
    filter();
  }

  setShape(ShapePref shape) {
    Hive.box(prefBox).put(prefShapeKey, shape);
    if (shape != this.shape.value) {
      this.shape.value = shape;
    }
  }

  setSortBy(SortPref sortBy) {
    Hive.box(prefBox).put(prefSortKey, sortBy);
    if (sortBy != this.sortBy.value) {
      this.sortBy.value = sortBy;
      filter();
    }
  }

  setLayout(LayoutPref layout) {
    Hive.box(prefBox).put(prefLayoutKey, layout);
    if (layout != this.layout.value) {
      this.layout.value = layout;
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

  bool _hasAccount() {
    Box<Account> box = Hive.box(accountBox);
    return box.values.isNotEmpty;
  }

  void checkIfFavorite() {
    if (_hasAccount()) {
      Box<Account> box = Hive.box(accountBox);
      accountID = box.values.first.id;
      if (box.get(accountID) == null) {
        isFavorite = false;
        update();
        return;
      }
      List<Address> addrs =
          box.get(accountID, defaultValue: Account.empty())!.addresses;

      if (addrs.isEmpty) {
        isFavorite = false;
        update();
      } else {
        bool addressContains = false;
        box
            .get(accountID, defaultValue: Account.empty())
            ?.addresses
            .forEach((addr) {
          if (addr.address == ethAddress) {
            addressContains = true;
          }
          if (addr.ens == ethAddress) {
            addressContains = true;
          }
        });
        isFavorite = addressContains;
        update();
      }
    } else {
      isFavorite = false;
      update();
    }
  }

  _addAddress(String address, String originEth, String originEns,
      {List<Address> addrs = const []}) async {
    List<String> ethAndEns =
        await VerificationHelper.getEthAndEns(this.ens, address);
    String eth = ethAndEns[0];
    String ens = ethAndEns[1];
    if (eth == '' && ens == '') {
      return;
    }
    Box<Account> box = Hive.box(accountBox);
    if (addrs.isNotEmpty) {
      addrs.add(Address(eth, ens, DateTime.now()));
      box.put(
          accountID,
          Account(
              id: accountID, eth: originEth, ens: originEns, addresses: addrs));
    } else {
      box.put(
        accountID,
        Account(
            id: accountID,
            eth: originEth,
            ens: originEns,
            addresses: [Address(eth, ens, DateTime.now())]),
      );
    }
  }

  _deleteAddress(String address, String originEth, String originEns,
      List<Address> addrs) async {
    List<String> ethAndEns =
        await VerificationHelper.getEthAndEns(this.ens, address);
    String eth = ethAndEns[0];
    String ens = ethAndEns[1];
    if (eth == '' && ens == '') {
      return;
    }
    Box<Account> box = Hive.box(accountBox);
    addrs.removeWhere((addr) => (addr.address == eth) || (addr.ens == ens));
    box.put(
        accountID,
        Account(
          id: accountID,
          eth: originEth,
          ens: originEns,
          addresses: addrs,
        ));
  }

  void toogleFavorite() async {
    /// no account, create account and address
    if (!_hasAccount()) {
      await _addAddress(ethAddress, '', '');
    } else {
      /// Have account, add address in account
      Box<Account> box = Hive.box(accountBox);

      List<Address> addrs =
          box.get(accountID, defaultValue: Account.empty())!.addresses;
      String originEth =
          box.get(accountID, defaultValue: Account.empty())!.eth ?? '';
      String originEns =
          box.get(accountID, defaultValue: Account.empty())!.ens ?? '';

      if (!isFavorite) {
        await _addAddress(ethAddress, originEth, originEns, addrs: addrs);
      }

      /// Have account, remove address in account
      else {
        await _deleteAddress(ethAddress, originEth, originEns, addrs);
      }
    }
    checkIfFavorite();
  }

  void _clearCountries() {
    countries.value = {};
  }

  void _getCountries(String? country) {
    if (country != null && country.isNotEmpty) {
      countries.value[country] = (countries.value[country] ?? 0) + 1;
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

  void _clearLayers() {}

  void _getLayers(String? layer) {}

  void sortLayers() {}

  void filter() {
    _clearCountries();
    _clearLayers();
    List<Token> rawTokensDataSortByTime = [];

    rawTokensDataSortByTime = tokens.value;

    /// Sort by time
    rawTokensDataSortByTime.sort((a, b) {
      if (a.event.startDate != null && b.event.endDate != null) {
        if (sortBy.value == SortPref.timeAsc) {
          return b.event.startDate!.compareTo(a.event.startDate!);
        }
        return a.event.startDate!.compareTo(b.event.startDate!);
      }
      return a.tokenId.compareTo(b.tokenId);
    });
    Map<int, Map<int, List<Token>>> tokensByYearAndMonth = {};
    Map<int, Map<int, Map<int, List<Token>>>> tokensByYearAndMonthAndDay = {};
    if (layout.value != LayoutPref.timeline) {
      for (var token in rawTokensDataSortByTime) {
        _getCountries(token.event.country);
        _getLayers(token.layer);
        if (filters.value['country'] != null &&
            filters.value['country'] != '') {
          if (token.event.country != filters.value['country']) {
            continue;
          }
        }
        if (filters.value['title'] != null && filters.value['title'] != '') {
          if (!token.event.name
              .toLowerCase()
              .contains(filters.value['title'].toLowerCase())) {
            continue;
          }
        }
        if (filters.value['description'] != null &&
            filters.value['description'] != '') {
          if (!token.event.description
              .toLowerCase()
              .contains(filters.value['description'].toLowerCase())) {
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
      }
    } else {
      for (var token in rawTokensDataSortByTime) {
        _getCountries(token.event.country);
        _getLayers(token.layer);
        if (filters.value['country'] != null &&
            filters.value['country'] != '') {
          if (token.event.country != filters.value['country']) {
            continue;
          }
        }
        if (filters.value['title'] != null && filters.value['title'] != '') {
          if (!token.event.name
              .toLowerCase()
              .contains(filters.value['title'].toLowerCase())) {
            continue;
          }
        }
        if (filters.value['description'] != null &&
            filters.value['description'] != '') {
          if (!token.event.description
              .toLowerCase()
              .contains(filters.value['desc'].toLowerCase())) {
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
      }
    }
    filteredTokensWithDay.value = tokensByYearAndMonthAndDay;
    filteredTokens.value = tokensByYearAndMonth;

    _generateTokenSpots();
    sortCountries();
    sortLayers();
  }

  toggleChartView() {
    if (chartView.value == 'growth') {
      chartView.value = 'monthly';
    } else {
      chartView.value = 'growth';
    }
  }

  final tokensRepository = getIt.get<POAPRepository>();

  _generateTokenSpots() {
    List<Token> rawTokensDataSortByTime = [];

    rawTokensDataSortByTime = tokens.value;

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

    Map tokenMap = tokensByYearAndMonth;

    int lastYear = 0;
    int lastMonth = 0;

    List<FlSpot> tempGrown = [];
    List<FlSpot> tempMonth = [];
    int maxGrowth = 0;
    int maxMonth = 0;

    double x = 0, y = 0, splitY = 0;
    tokenMap.forEach((year, tokensInMonth) {
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

        tempMonth.add(FlSpot(x, splitY));

        y = tokens.length + y;

        tempGrown.add(FlSpot(x, y));

        if (maxMonth < splitY) {
          maxMonth = splitY.toInt();
        }

        maxGrowth = tokens.length + maxGrowth;
      });
    });
    growthTokenSpots.value = tempGrown;
    monthlyTokenSpots.value = tempMonth;
    maxTokensInGrowthView.value = maxGrowth;
    maxTokensInMonthlyView.value = maxMonth;

    maxXLine.value = x.toInt();
  }

  int _getUniqueCount() {
    List<int> uniqueEventIDList = [];
    for (var token in tokens.value) {
      if (!uniqueEventIDList.contains(token.event.id)) {
        uniqueEventIDList.add(token.event.id);
      }
    }
    return uniqueEventIDList.length;
  }

  void getCachedData() {
    Box<Token> box = Hive.box(poapBox);
    var allCachedData = box.values;

    List<Token> cachedData = allCachedData.where((token) {
      return token.owner.toLowerCase() == ethAddress.toLowerCase();
    }).toList();

    if (cachedData.isNotEmpty) {
      tokens.value = cachedData;
      _updateStatus();
    }
    cacheLoadingStatus = CacheLoadingStatus.loaded;
    update();
  }

  void cacheData() {
    if (tokens.value.length > 1000) {
      return;
    }
    Box<Token> box = Hive.box(poapBox);

    for (var token in tokens.value) {
      box.put(token.tokenId, token);
    }
  }

  void _updateStatus() {
    count.value = tokens.length;
    uniqueCount.value = _getUniqueCount();
    filter();
  }

  void _updateLoadingStatus(LoadingStatus s) {
    loadingStatus = s;
    update();
  }

  void getData() async {
    if (cacheLoadingStatus == CacheLoadingStatus.loaded) {
      if (count.value == 0) {
        count.value = 0;
        uniqueCount.value = 0;
        tokens.value = [];
        filteredTokens.value = {};
        filteredTokensWithDay.value = {};
      }
    }

    error.value = '';
    cacheLoadingStatus = CacheLoadingStatus.loaded;
    update();
    _updateLoadingStatus(LoadingStatus.loading);
    if (ethAddress == '') {
      return;
    }
    var response = await tokensRepository.scan(ethAddress);
    tokens.value = response;
    _updateLoadingStatus(LoadingStatus.loaded);
    _updateStatus();
    cacheData();
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
