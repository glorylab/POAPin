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

  Future<MomentResponse> getMomentsOfAddress(
    String address, {
    int limit = 1,
    int offset = 0,
    String sort = 'asc',
  }) async {
    try {
      String checksumAddress = checksumEthereumAddress(address);
      final response = await welookAPI.getMomentsOfAddress(
        checksumAddress,
        limit: limit,
        offset: offset,
        sort: sort,
      );
      MomentResponse momentResponse = MomentResponse.fromJson(response.data);
      return momentResponse;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<MomentResponse> getMomentsOfEvent(
    int eventID, {
    int limit = 20,
    int offset = 0,
    String sort = 'asc',
  }) async {
    try {
      final response = await welookAPI.getMomentsOfEvent(
        eventID,
        limit: limit,
        offset: offset,
        sort: sort,
      );
      MomentResponse momentResponse = MomentResponse.fromJson(response.data);
      return momentResponse;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
