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
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
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
