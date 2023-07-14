

import 'package:pkp_socket/data/datasources/model/message_model.dart';
import 'package:pkp_socket/domain/entities/message_entity.dart';

Stream<MessageModel> toMessageModel(MessageEntity messageEntity) async* {
  yield MessageModel(message : messageEntity.message);
}