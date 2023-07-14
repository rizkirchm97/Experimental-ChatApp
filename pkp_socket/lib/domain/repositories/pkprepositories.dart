import 'package:dartz/dartz.dart';
import 'package:pkp_socket/core/network/network_state.dart';
import 'package:pkp_socket/data/datasources/model/message_model.dart';
import 'package:pkp_socket/data/datasources/model/room_model.dart';
import 'package:pkp_socket/domain/entities/message_entity.dart';

import '../entities/room_entity.dart';

abstract class PkpRepositories {
  Future<void> connect();

  Future<void> disconnect();

  Future<void> send(MessageEntity messageEntity);

  Future<Tuple3<Stream<MessageEntity>?, Stream<List<RoomEntity>>?,
          Future<List<MessageEntity>>?>?> onMessage(NetworkState networkState);
}
