import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pkp_socket/core/network/api_provider.dart';
import 'package:pkp_socket/data/datasources/model/message_model.dart';

abstract class HttpService {
  Future<List<MessageModel>> getPendingDatas({required String url});
}

class HttpServiceImpl extends HttpService {
  final Dio _dio;

  HttpServiceImpl(this._dio);

  @override
  Future<List<MessageModel>> getPendingDatas({required String url}) async {
    final response = await _dio.get(
      ApiProvider.HTTP1_BASE_URL + url,
      options: Options(responseType: ResponseType.json)
    );

    final result = (response.data as List).map((data) {
      final decode = jsonDecode(data);
      return MessageModel.fromJson(decode);
    }).toList();

    return result;
  }
}
