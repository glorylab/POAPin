import 'package:dio/dio.dart';
import 'package:poapin/data/network/api/constant/gitpoap.dart';
import 'package:poapin/data/network/client/dio_gitpoap.dart';

class GitPOAPApi {
  final DioGitPOAPClient dioClient;

  GitPOAPApi({required this.dioClient});

  Future<Response> isEventGitPOAP(int eventID) async {
    try {
      final Response response = await dioClient.get(
        GitPOAPConstant.isEventGitPOAP(eventID),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
