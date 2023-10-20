import 'package:dio/dio.dart';
import 'package:poapin/data/models/gitpoap.dart';
import 'package:poapin/data/network/api/gitpoap.dart';
import 'package:poapin/data/network/exceptions.dart';

class GitPOAPRepository {
  final GitPOAPApi gitPOAPAPI;

  GitPOAPRepository(this.gitPOAPAPI);

  Future<Map> isEventGitPOAP(int eventID) async {
    try {
      final response = await gitPOAPAPI.isEventGitPOAP(eventID);
      final gitPOAPID = (response.data['gitPOAPId'] as int?) ?? 0;
      final isGitPOAP = (response.data['isGitPOAP'] as bool?) ?? false;
      return {
        'gitPOAPID': gitPOAPID,
        'isGitPOAP': isGitPOAP,
      };
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<GitPoap>> scan(String address) async {
    try {
      final response = await gitPOAPAPI.scan(address);

      if (response.data is List) {
        final gitPOAPs =
            (response.data as List).map((e) => GitPoap.fromJson(e)).toList();
        return gitPOAPs;
      }
      if (response.data['msg'] != null) {
        throw response.data['msg'];
      }
      if (response.data['message'] != null) {
        throw response.data['message'];
      }
      throw 'Unknown error';
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
