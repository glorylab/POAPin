import 'package:dio/dio.dart';
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
}
