import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pkp_socket/data/datasources/model/message_model.dart';
import 'package:pkp_socket/domain/entities/message_entity.dart';

@immutable
abstract class DetailMessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessageReceivedState extends DetailMessageState {
  final List<MessageEntity>? message;
  bool? isOnline;
  bool? isOffline;
  bool? isTyping;

  MessageReceivedState({
    this.message,
    this.isOnline,
    this.isOffline,
    this.isTyping,
  });

  MessageReceivedState copyWith({
    final List<MessageEntity>? message,
    bool? isOnline,
    bool? isOffline,
    bool? isTyping,
    String? userId,
  }) =>
      MessageReceivedState(
        message: message,
        isOnline: isOnline,
        isOffline: isOffline,
        isTyping: isTyping,
      );

  @override
  List<Object?> get props => [
        message,
        isOnline,
        isOffline,
        isTyping,
      ];
}

class ConnectSocketState extends DetailMessageState {}

class DisconnectSocketState extends DetailMessageState {}

class DetailMessageInitialState extends DetailMessageState {}

class Empty extends DetailMessageState {}

class Loading extends DetailMessageState {}

class Loaded extends DetailMessageState {
  final MessageEntity? messageData;

  Loaded({required this.messageData});

  @override
  List<Object?> get props => [messageData];

  Loaded copyWith({MessageEntity? message}) {
    return Loaded(messageData: message ?? messageData);
  }
}

class Error extends DetailMessageState {
  final String errorMessage;

  Error({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
