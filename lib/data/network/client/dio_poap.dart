import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:poapin/common/constants.dart';
import 'package:poapin/data/models/account.dart';
import 'package:poapin/data/network/api/constant/base.dart';
import 'package:poapin/data/network/api/constant/poap.dart';

class DioPOAPClient {
  final Dio _dio = Dio();

  DioPOAPClient() {
    _dio
      ..options.baseUrl = POAPConstant.poapUrl
      ..options.connectTimeout = const Duration(milliseconds: BaseConstant.connectionTimeout)
      ..options.receiveTimeout = const Duration(milliseconds: BaseConstant.receiveTimeout)
      ..options.responseType = ResponseType.json
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-API-Key': POAPConstant.poapAPIKey,
      };
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool? isAuthorized = false,
  }) async {
    if (isAuthorized != null && isAuthorized) {
      _dio.options.headers['Authorization'] = '${_getPOAPToken()}';
    }
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  String? _getPOAPToken() {
    Box<Account> box = Hive.box(accountBox);
    if (box.values.isNotEmpty) {
      var acc = box.values.first;
      String? poapToken = acc.poapToken;
      return poapToken;
    }
    return null;
  }
}
