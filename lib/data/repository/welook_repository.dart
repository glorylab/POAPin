import 'package:dio/dio.dart';
import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:poapin/data/models/moment.dart';
import 'package:poapin/data/network/api/welook.dart';
import 'package:poapin/data/network/exceptions.dart';

class WelookRepository {
  final WelookApi welookAPI;

  WelookRepository(this.welookAPI);

  Future<int> count(int eventID) async {
    try {
      final response = await welookAPI.count(eventID);
      final total = response.data['total'] as int?;
      return total ?? 0;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<Moment>> getMomentsOfAddress(String address) async {
    try {
      String checksumAddress = checksumEthereumAddress(address);
      final response = await welookAPI.getMomentsOfAddress(checksumAddress);
      final total = (response.data['total'] as int?) ?? 0;
      if (total == 0) {
        return [];
      } else {
        final moments = response.data['photos'] as List<dynamic>;
        return moments.map((moment) => Moment.fromJson(moment)).toList();
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
