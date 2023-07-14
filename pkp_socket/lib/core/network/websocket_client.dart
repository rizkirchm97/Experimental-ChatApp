import 'package:pkp_socket/core/network/api_provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClient{
  static WebSocketChannel connect(String? userId, String? roomId) {
    return IOWebSocketChannel.connect(
      ApiProvider.WEBSOCKET_BASE_URL+ApiProvider.GET_BY_USER_ID_AND_ROOM_S(userId, roomId),
      pingInterval: const Duration(seconds: 5),
      connectTimeout: const Duration(seconds: 60),
    );
  }

  // 1/jawa
}