import 'dart:async';
import 'dart:convert';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:pkp_socket/core/network/api_provider.dart';
import 'package:pkp_socket/core/network/sse_second_client.dart';
import 'package:pkp_socket/data/datasources/model/room_model.dart';

import '../../../../core/network/sse_client.dart';
import '../../model/message_model.dart';

abstract class SseService {
  Stream<List<RoomModel>>? get onMessage;
}

class SseServiceImpl extends SseService {
  final SSESecondClient _sseSecondClient;
  //
  SseServiceImpl(this._sseSecondClient);

  @override
  Stream<List<RoomModel>>? get onMessage async*  {

    final response = _sseSecondClient.onMessage('jawa');

    yield* response.map((data) {
      final List<dynamic> jsonArray = jsonDecode(data!);
      return jsonArray.map((dynamic json) {
        return RoomModel.fromJson(json);
      }).toList();
    });


    // final response =
    //     _sseClient.connect(ApiProvider.GET_BY_USER_ID_AND_ROOM_H('jawa'));
    //
    // return response.map((dynamic data) {
    //   final List<dynamic> jsonArray = jsonDecode(data);
    //   return jsonArray.map((dynamic json) {
    //     return MessageModel.fromJson(json);
    //   }).toList();
    // });

    // final response = SseClient(
    //   ApiProvider.BASE_URL + ApiProvider.GET_BY_USER_ID_AND_ROOM_H('jawa'),
    // );
    //
    // yield* response.stream.map((dynamic data) {
    //   final decodeData = jsonDecode(data);
    //   return MessageModel.fromJson(decodeData);
    // });

    // final response = await _dio.get(
    //   ApiProvider.GET_BY_USER_ID_AND_ROOM_H('jawa'),
    //   options: Options(
    //     responseType: ResponseType.stream,
    //   ),
    // );
    // yield* response.data;
  }
}
