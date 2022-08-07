import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poapin/data/network/api/constant/base.dart';
import 'package:poapin/data/network/api/constant/poapin.dart';

class DioPOAPINClient {
  final Dio _dio = Dio();

  DioPOAPINClient() {
    _dio
      ..options.baseUrl = POAPINConstant.baseUrl
      ..options.connectTimeout = BaseConstant.connectionTimeout
      ..options.receiveTimeout = BaseConstant.receiveTimeout
      ..options.responseType = ResponseType.json
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-API-Key': POAPINConstant.poapinAPIKey,
      };
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    await _setToken();
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
    await _setToken();
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
    await _setToken();
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
    await _setToken();
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

  _setToken() async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken(true);
    _dio.options.headers['Authorization'] = 'Bearer $idToken';
  }
}
