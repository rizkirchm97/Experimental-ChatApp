import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:pkp_socket/core/network/api_provider.dart';
import 'package:pkp_socket/core/network/custom_http_cleint_adapter.dart';

class DioClient {
  static Dio connect() {
    return Dio()
      ..options.baseUrl = ApiProvider.HTTP1_BASE_URL
      ..interceptors.add(LogInterceptor())
      ..httpClientAdapter = HttpClientAdapter();
  }
}
