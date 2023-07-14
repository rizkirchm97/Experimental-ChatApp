import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {

  String? _messageId;
  String? _userId;
  String? _userName;
  String? _message;
  String? _sendDatetime;

  MessageEntity({ String? messageId,
    String? userId,
    String? userName,
    String? message,
    String? sendDatetime,
  }) {
    _messageId = messageId;
    _userId = userId;
    _userName = userName;
    _message = message;
    _sendDatetime = (sendDatetime ?? DateTime.now().millisecondsSinceEpoch.toString());
  }

  @override
  List<Object?> get props => [messageId, userId, userName, message, sendDatetime];

  @override
  bool? get stringify => true;

  MessageEntity.fromJson(dynamic json) {
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

  MessageEntity copyWith({
    String? messageId,
    String? userId,
    String? userName,
    String? message,
    String? sendDatetime,
  }) => MessageEntity(
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

}