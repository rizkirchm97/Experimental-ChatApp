import 'dart:convert';
import 'dart:io';

import 'package:pkp_socket/core/network/websocket_client.dart';
import 'package:pkp_socket/data/datasources/model/message_model.dart';
import 'package:pkp_socket/di/app_module.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../core/network/api_provider.dart';

abstract class PkpWebSocketService {
  Future<void> connect();

  Future<void> disconnect();

  Future<void> send(MessageModel messageModel);

  Stream<MessageModel>? get onMessage;
}

class PkpWebSocketClientImpl implements PkpWebSocketService {
  final WebSocketChannel? _webSocket;

  PkpWebSocketClientImpl(this._webSocket);

  @override
  Future<void> disconnect() async {
    await _webSocket?.sink.close();
  }

  @override
  Future<void> send(MessageModel? messageModel) async {
    Map? sendResult = messageModel?.toJson();
    final jsonMessage = const JsonEncoder.withIndent('  ').convert(sendResult);
    print(sendResult);
    _webSocket?.sink.add(jsonMessage);
  }

  @override
  Stream<MessageModel>? get onMessage {
    return _webSocket?.stream.map((dynamic data) {
      final decodeData = jsonDecode(data);
      return MessageModel.fromJson(decodeData);
    });
  }

  @override
  Future<void> connect() async {
    try {
      // getIt.registerSingleton<PkpWebSocketService>(PkpWebSocketClientImpl(WebSocketClient.connect('jawa', '1') as WebSocketChannel));
    } catch (err) {
      print(err.toString());
    }
  }
}
