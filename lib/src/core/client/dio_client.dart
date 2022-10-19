import 'package:dio/dio.dart';
import 'package:petscape/src/core/client/interceptors/dio_interceptors.dart';

import 'endpoints.dart';

enum RequestType { get, post, put, patch, delete, postForm }

class DioClient {
  final String? baseUrl;
  DioClient({this.baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? Endpoints.baseURL,
        connectTimeout: Endpoints.connectionTimeout,
        receiveTimeout: Endpoints.receiveTimeout,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([DioInterceptors()]);
  }

  late final Dio _dio;

  Future<Response<dynamic>> apiCall({
    required String url,
    required RequestType requestType,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? header,
    RequestOptions? requestOptions,
  }) async {
    late Response result;

    switch (requestType) {
      case RequestType.get:
        {
          Options options = Options(headers: header);
          result = await _dio.get(url, queryParameters: queryParameters, options: options);
          break;
        }
      case RequestType.post:
        {
          Options options = Options(headers: header);
          result = await _dio.post(url, data: body, options: options);
          break;
        }
      case RequestType.delete:
        {
          Options options = Options(headers: header);
          result = await _dio.delete(url, data: queryParameters, options: options);
          break;
        }
      case RequestType.put:
        {
          Options options = Options(headers: header);
          result = await _dio.put(url, data: body, options: options);
          break;
        }
      case RequestType.patch:
        {
          Options options = Options(headers: header);
          result = await _dio.put(url, data: body, options: options);
          break;
        }
      case RequestType.postForm:
        break;
    }
    return result;
  }
}
