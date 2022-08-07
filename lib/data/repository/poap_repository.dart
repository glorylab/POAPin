import 'package:dio/dio.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/data/network/api/poap.dart';
import 'package:poapin/data/network/exceptions.dart';

class POAPRepository {
  final POAPAPI poapAPI;

  POAPRepository(this.poapAPI);

  Future<List<Token>> scan(String address) async {
    try {
      final response = await poapAPI.scan(address);
      final tokens =
          (response.data as List).map((e) => Token.fromJson(e)).toList();
      return tokens;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Token> getToken(String tokenID) async {
    try {
      final response = await poapAPI.getToken(tokenID);
      final token = Token.fromJson(response.data);
      return token;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Token> getPOAPsOfEvent(int eventID) async {
    try {
      final response = await poapAPI.getPOAPsOfEvent(eventID);
      final token = Token.fromJson(response.data);
      return token;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
