import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ekank/helpers/http_helpers/api_constant.dart';
import 'package:ekank/helpers/logging.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstant.mainApiUrl,
      connectTimeout: 90000,
      receiveTimeout: 90000,
      sendTimeout: 90000,
      followRedirects: true,
      headers: {"X-Api-Key": ApiConstant.apiKey},
    ),
  )..interceptors.add(Logging());

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      // print('----response--get....:$response');

      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
