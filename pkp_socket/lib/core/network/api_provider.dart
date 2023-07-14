class ApiProvider {
  // WEB SOCKET
  static String WEBSOCKET_BASE_URL = "ws://192.168.90.111:3002/ws/";

  static String GET_BY_USER_ID_AND_ROOM_S(String? userId, String? roomId) =>
      "$roomId/$userId";

  // HTTP2 SSE Connection
  static String BASE_URL = "http://192.168.90.111:3001/sse/";

  static String GET_BY_USER_ID_AND_ROOM_H(String? userId) => "$userId";

  // HTTP 1 Get Pending Message
  static String HTTP1_BASE_URL = "http://192.168.90.111:3002/";

  static String GET_MESSAGE_LIST_BY_USER_ID_AND_ROOM_ID(String? roomId, String? userId) =>
      "init_chat/$roomId/$userId";
}
