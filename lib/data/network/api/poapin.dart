import 'package:dio/dio.dart';
import 'package:poapin/data/network/api/constant/poapin.dart';
import 'package:poapin/data/network/client/dio_poapin.dart';

class POAPINAPI {
  final DioPOAPINClient dioClient;

  POAPINAPI({required this.dioClient});

  Future<Response> gm() async {
    try {
      final Response response = await dioClient.post(
        POAPINConstant.gm,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
