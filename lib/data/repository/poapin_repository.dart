import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:poapin/common/constants.dart';
import 'package:poapin/data/models/account.dart';
import 'package:poapin/data/network/api/poapin.dart';
import 'package:poapin/data/network/exceptions.dart';

class POAPINRepository {
  final POAPINAPI poapinAPI;

  POAPINRepository(this.poapinAPI);

  Future gm() async {
    try {
      final response = await poapinAPI.gm();
      final code = response.data['code'] as int?;
      if (code == 0) {
        final poapToken = response.data['poap_token'];
        _savePOAPToken(poapToken);
        return poapToken;
      } else {
        return null;
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String> gmgm() async {
    try {
      final response = await poapinAPI.gmgm();
      final code = response.data['code'] as int?;
      if (code == 0) {
        final poapToken = response.data['gm'];
        _savePOAPToken(poapToken);
        return poapToken;
      } else {
        return '';
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  getPOAPToken() async {
    if (getLocalPOAPToken().isnotEmpty) {
      return getLocalPOAPToken();
    } else {
      return await refreshPOAPToken();
    }
  }

  getLocalPOAPToken() async {
    final box = Hive.box(accountBox);
    if (box.values.isNotEmpty) {
      String accountID = box.values.first.id;
      Account? account = box.get(accountID);
      if (account != null) {
        return account.poapToken;
      }
    }
    return '';
  }

  Future<String> refreshPOAPToken() {
    return gmgm();
  }

  void _savePOAPToken(String poapToken) {
    Box<Account> box = Hive.box(accountBox);
    if (box.values.isNotEmpty) {
      String accountID = box.values.first.id;
      Account? account = box.get(accountID);
      if (account != null) {
        account.poapToken = poapToken;
        box.put(accountID, account);
      } else {
        box.put(accountID,
            Account(id: accountID, poapToken: poapToken, addresses: []));
      }
    }
  }
}
