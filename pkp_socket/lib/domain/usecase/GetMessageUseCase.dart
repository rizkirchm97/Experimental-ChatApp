

import 'package:dartz/dartz.dart';
import 'package:pkp_socket/core/network/network_state.dart';
import 'package:pkp_socket/domain/entities/room_entity.dart';
import 'package:pkp_socket/domain/repositories/pkprepositories.dart';

import '../entities/message_entity.dart';

class GetMessageUseCase {
  final PkpRepositories pkpRepositories;


  GetMessageUseCase(this.pkpRepositories);

  Future<Tuple3<Stream<MessageEntity>?, Stream<List<RoomEntity>>?, Future<List<MessageEntity>>?>?> invoke(NetworkState networkState) => pkpRepositories.onMessage(networkState);

}