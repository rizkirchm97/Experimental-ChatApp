import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/message_entity.dart';
import '../../../domain/entities/room_entity.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPendingChatEvent extends HomeEvent {
  final String? responseCode;
  final String? responseMessage;
  final List<MessageEntity>? message;
  final List<RoomEntity>? roomList;

  GetPendingChatEvent({
    this.responseCode,
    this.responseMessage,
    this.message,
    this.roomList,
  });

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        message,
        roomList,
      ];
}
