import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pkp_socket/domain/entities/room_entity.dart';

import '../../../domain/entities/message_entity.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPendingMessageState extends HomeState {
  final String? responseCode;
  final String? responseMessage;
  final List<RoomEntity>? roomEntity;

  GetPendingMessageState({
    this.responseCode,
    this.responseMessage,
    this.roomEntity,
  });

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        roomEntity,
      ];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeEmptyState extends HomeState {}

class HomeErrorState extends HomeState {
  final String? errorCode;
  final String? errorMessage;

  HomeErrorState({this.errorMessage, this.errorCode});

  @override
  List<Object?> get props => [errorMessage, errorCode];
}
