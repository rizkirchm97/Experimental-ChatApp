import 'package:equatable/equatable.dart';
import 'package:pkp_socket/domain/entities/message_entity.dart';
import 'package:pkp_socket/domain/repositories/pkprepositories.dart';

class SendMessageUseCase {
  final PkpRepositories pkpRepositories;

  SendMessageUseCase(this.pkpRepositories);

  Future<void> invoke(MessageEntity message) async {
   await pkpRepositories.send(message);
  }

}

class Params extends Equatable {
  final String message;

  const Params({required this.message});

  @override
  List<Object?> get props => [message];

}