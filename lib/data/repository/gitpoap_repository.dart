import 'package:dio/dio.dart';
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
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
