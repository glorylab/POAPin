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

  Future<Response> getMomentsOfEvent(
    int eventID, {
    int limit = 20,
    int offset = 0,
    String sort = 'asc',
  }) async {
    try {
      final Response response = await dioClient.get(
        WelookConstant.getMementsOfEvent(
          eventID,
          limit: limit,
          offset: offset,
          sort: sort,
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMomentsOfAddress(
    String address, {
    int limit = 20,
    int offset = 0,
    String sort = 'asc',
  }) async {
    try {
      final Response response = await dioClient.get(
        WelookConstant.getMomentsOfAddress(
          address,
          limit: limit,
          offset: offset,
          sort: sort,
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMomentsOfAddressInEvent(
    String address,
    int eventID, {
    int limit = 20,
    int offset = 0,
    String sort = 'asc',
  }) async {
    try {
      final Response response = await dioClient.get(
        WelookConstant.getMomentsOfAddressInEvent(
          address,
          eventID,
          limit: limit,
          offset: offset,
          sort: sort,
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMoment(
    int momentID, {
    int limit = 20,
    int offset = 0,
    String sort = 'asc',
  }) async {
    try {
      final Response response = await dioClient.get(
        WelookConstant.getMoment(
          momentID,
          limit: limit,
          offset: offset,
          sort: sort,
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
