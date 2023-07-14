class MessageModel {
  String? _messageId;
  String? _userId;
  String? _userName;
  String? _message;
  String? _sendDatetime;

  MessageModel({
    String? messageId,
    String? userId,
    String? userName,
    String? message,
    String? sendDatetime,
  }) {
    _messageId = messageId;
    _userId = userId;
    _userName = userName;
    _message = message;
    _sendDatetime = sendDatetime;
  }

  MessageModel.fromJson(dynamic json) {
    _messageId = json['messageId'];
    _userId = json['userId'];
    _userName = json['userName'];
    _message = json['message'];
    _sendDatetime = json['sendDatetime'];
  }

  String? get messageId => _messageId;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get message => _message;
  String? get sendDatetime => _sendDatetime;

  MessageModel copyWith({
    String? messageId,
    String? userId,
    String? userName,
    String? message,
    String? sendDatetime,
  }) =>
      MessageModel(
        messageId: messageId ?? _messageId,
        userId: userId ?? _userId,
        userName: userName ?? _userName,
        message: message ?? _message,
        sendDatetime: _sendDatetime ?? _sendDatetime,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['messageId'] = _messageId;
    map['userId'] = _userId;
    map['userName'] = _userName;
    map['message'] = _message;
    map['sendDatetime'] = _sendDatetime;
    return map;
  }

  static List<MessageModel> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        .map((dynamic json) => MessageModel.fromJson(json))
        .toList();
  }
}
