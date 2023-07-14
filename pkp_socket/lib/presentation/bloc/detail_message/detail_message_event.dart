import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/message_entity.dart';

@immutable
abstract class DetailMessageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMessageEvent extends DetailMessageEvent {

  MessageEntity? message;
  String? messageError;

  GetMessageEvent({this.message, this.messageError});
}

class SendMessageEvent extends DetailMessageEvent {
  final String? message;

  SendMessageEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class ConnectSocketEvent extends DetailMessageEvent {
  late final String _userId;
  late final String _roomId;

  ConnectSocketEvent({ required String userId, required String roomId }) {
    _userId = userId;
    _roomId = roomId;
  }

  String get roomId => _roomId;
  String get userId => _userId;
}

class DisconnectSocketEvent extends DetailMessageEvent {}
