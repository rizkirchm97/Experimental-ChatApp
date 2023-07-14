import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:pkp_socket/core/network/api_provider.dart';
import 'package:pkp_socket/core/network/network_state.dart';
import 'package:pkp_socket/data/datasources/model/message_model.dart';
import 'package:pkp_socket/data/datasources/network/http/http_service.dart';
import 'package:pkp_socket/data/datasources/network/sse/sse_service.dart';
import 'package:pkp_socket/data/datasources/network/websocket/websocket.dart';
import 'package:pkp_socket/data/mappers/to_entity.dart';
import 'package:pkp_socket/domain/entities/message_entity.dart';
import 'package:pkp_socket/domain/entities/room_entity.dart';
import 'package:pkp_socket/domain/repositories/pkprepositories.dart';

import '../../core/network/sse_client.dart';

class PkpRepositoriesImpl extends PkpRepositories {
  final PkpWebSocketService _pkpWebSocketClient;
  final SseService _sseService;
  final HttpService _httpService;

  PkpRepositoriesImpl({
    required PkpWebSocketService pkpWebSocketClient,
    required SseService sseService,
    required HttpService httpService,
  })  : _pkpWebSocketClient = pkpWebSocketClient,
        _sseService = sseService,
        _httpService = httpService;

  @override
  Future<void> disconnect() async {
    await _pkpWebSocketClient.disconnect();
  }

  @override
  Future<
      Tuple3<Stream<MessageEntity>?, Stream<List<RoomEntity>>?,
          Future<List<MessageEntity>>?>?> onMessage(
      NetworkState networkState) async {
    if (networkState == NetworkState.WEBSOCKET_PROTOCOL) {
      return Tuple3(
        _pkpWebSocketClient.onMessage?.map((data) => MessageEntity(
              messageId: data.messageId,
              userName: data.userName,
              message: data.message,
              userId: data.userId,
              sendDatetime: data.sendDatetime,
            )),
        null,
        null,
      );
    } else if (networkState == NetworkState.SSE_PROTOCOL) {
      // final res = _sseService.onMessage?.map((datas) {
      //     return datas.map((data) {
      //       return RoomEntity(
      //         id: data.id,
      //         Room: data.Room,
      //         Room_type: data.Room_type,
      //         Members: data.Members,
      //         Created_datetime: data.Created_datetime,
      //         Updated_datetime: data.Updated_datetime,
      //         Last_sync_datetime: data.Last_sync_datetime,
      //       );
      //     }).toList();
      //   },
      // );

      // print('MAPPED SSE DATA ${res?.toList().asStream()}');

      return Tuple3(
        null,
        _sseService.onMessage?.map(
          (datas) {
            return datas.map((data) {
              return RoomEntity(
                id: data.id,
                Room: data.Room,
                Room_name: data.Room_name,
                Room_type: data.Room_type,
                Members: data.Members,
                Created_datetime: data.Created_datetime,
                Updated_datetime: data.Updated_datetime,
                Last_sync_datetime: data.Last_sync_datetime,
              );
            }).toList();
          },
        ),
        null,
      );
    } else if (networkState == NetworkState.HTTP1_PROTOCOL) {
      final result = await _httpService.getPendingDatas(
        url: ApiProvider.GET_MESSAGE_LIST_BY_USER_ID_AND_ROOM_ID('1', 'jawa'),
      );

      final mappedDatas = result
          .map((data) => MessageEntity(
                userId: data.userId,
                messageId: data.messageId,
                userName: data.userName,
                message: data.message,
                sendDatetime: data.sendDatetime,
              ))
          .toList();

      return Tuple3(
        null,
        null,
        mappedDatas as Future<List<MessageEntity>>?,
      );
    }
    return null;
  }

  @override
  Future<void> send(MessageEntity messageEntity) async {
    await _pkpWebSocketClient.send(toFutureMessageModel(messageEntity));
  }

  @override
  Future<void> connect() async {
    await _pkpWebSocketClient.connect();
  }
}
