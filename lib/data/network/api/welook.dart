import 'package:dio/dio.dart';
import 'package:poapin/data/network/api/constant/welook.dart';
import 'package:poapin/data/network/client/dio_welook.dart';

class WelookApi {
  final DioWelookClient dioClient;

  WelookApi({required this.dioClient});

  Future<Response> count(int eventID) async {
    try {
      final Response response = await dioClient.get(
        WelookConstant.momentCount(eventID),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
