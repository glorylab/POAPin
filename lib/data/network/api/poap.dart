import 'package:dio/dio.dart';
import 'package:poapin/data/network/api/constant/poap.dart';
import 'package:poapin/data/network/client/dio_poap.dart';

class POAPAPI {
  final DioPOAPClient dioClient;

  POAPAPI({required this.dioClient});

  Future<Response> scan(String address) async {
    try {
      final Response response = await dioClient.get(
        POAPConstant.scan(address),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getToken(String tokenID) async {
    try {
      final Response response = await dioClient.get(
        POAPConstant.token(tokenID),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getPOAPsOfEvent(int eventID) async {
    try {
      final Response response = await dioClient.get(
        POAPConstant.poaps(eventID),
        isAuthorized: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
