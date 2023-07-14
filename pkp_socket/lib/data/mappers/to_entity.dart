import 'package:pkp_socket/data/datasources/model/message_model.dart';
import 'package:pkp_socket/domain/entities/message_entity.dart';

Stream<MessageEntity>? toStreamMessageEntity(
    Stream<MessageModel>? messageModel) {
  return messageModel?.map((response) =>
      MessageEntity(message: response.message, userId: response.userId));
}

Stream<MessageModel>? toStreamMessageModel(
    Stream<MessageEntity>? messageEntity) {
  return messageEntity
      ?.map((response) => MessageModel(message: response.message));
}

MessageEntity toFutureMessageEntity(MessageModel? messageModel) {
  return MessageEntity(
    message: messageModel?.message,
    userName: messageModel?.userName,
    messageId: messageModel?.messageId,
    userId: messageModel?.userId,
    sendDatetime: messageModel?.sendDatetime,
  );
}

MessageModel toFutureMessageModel(MessageEntity messageEntity) {
  return MessageModel(
    messageId: messageEntity.messageId,
    userName: messageEntity.userName,
    message: messageEntity.message,
    userId: messageEntity.userId,
    sendDatetime: messageEntity.sendDatetime,
  );
}
