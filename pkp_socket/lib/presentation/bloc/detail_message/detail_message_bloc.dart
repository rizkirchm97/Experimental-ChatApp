import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkp_socket/core/helper.dart';
import 'package:pkp_socket/core/network/network_state.dart';
import 'package:pkp_socket/domain/entities/message_entity.dart';
import 'package:retry/retry.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../domain/usecase/ConnectConnectionUseCase.dart';
import '../../../domain/usecase/DisconnectConnectionUseCase.dart';
import '../../../domain/usecase/GetMessageUseCase.dart';
import '../../../domain/usecase/SendMessageUseCase.dart';
import 'detail_message_event.dart';
import 'detail_message_state.dart';

class DetailMessageBloc extends Bloc<DetailMessageEvent, DetailMessageState> {
  final GetMessageUseCase _getMessageUserCase;
  final SendMessageUseCase _sendMessageUseCase;
  final DisconnectConnectionUseCase _disconnectConnectionUseCase;
  final ConnectConnectionUseCase _connectConnectionUseCase;

  final List<MessageEntity> _listMessage = [];

  DetailMessageBloc(
      {required GetMessageUseCase getMessageUserCase,
      required SendMessageUseCase sendMessageUseCase,
      required DisconnectConnectionUseCase disconnectConnectionUseCase,
      required ConnectConnectionUseCase connectConnectionUseCase})
      : _connectConnectionUseCase = connectConnectionUseCase,
        _disconnectConnectionUseCase = disconnectConnectionUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        _getMessageUserCase = getMessageUserCase,
        super(DetailMessageInitialState()) {
    on<GetMessageEvent>(_mapGetMessageToState);
    on<SendMessageEvent>(_mapSendMessageToState);
    on<ConnectSocketEvent>(_mapConnectSocketToState);
    on<DisconnectSocketEvent>(_mapDisconnectSocketToState);

    _init();
  }

  @override
  DetailMessageState get state => Empty();

  Future<void> _mapSendMessageToState(
      DetailMessageEvent event, Emitter<DetailMessageState> emit) async {
    if (event is SendMessageEvent) {
      emit(Loading());
      try {
        await _sendMessageUseCase.invoke(MessageEntity(
          messageId: await generateMessageId(userId: 'jawa', roomId: '1'),
          userId: 'jawa',
          userName: 'jawa',
          message: '${event.message}',
        ));
      } catch (err) {
        emit(Error(errorMessage: err.toString()));
      }
    }
  }

  Future<void> _mapGetMessageToState(
      GetMessageEvent event, Emitter<DetailMessageState> emit) async {
    emit(Loading());
    try {
      if (event.message != null) {
        _listMessage.add(event.message!);
        emit(MessageReceivedState(
          message: List.from(_listMessage),
        ));
      } else {
        emit(Error(errorMessage: "You don't have any chat history"));
      }
    } catch (err) {
      print(err);
      emit(Error(errorMessage: err.toString()));
    }
  }

  Future<void> _mapConnectSocketToState(
      ConnectSocketEvent event, Emitter<DetailMessageState> emit) async {
    await _connectConnectionUseCase.invoke();
  }

  Future<void> _mapDisconnectSocketToState(
      DisconnectSocketEvent event, Emitter<DetailMessageState> emit) async {
    await _disconnectConnectionUseCase.invoke();
  }

  Future<void> _init() async {
    try {
      final result =
          await _getMessageUserCase.invoke(NetworkState.WEBSOCKET_PROTOCOL);
      const retryOptions = RetryOptions(maxAttempts: 2);

      result?.value1?.listen((message) {
        add(GetMessageEvent(message: message));
      }, onError: (error, stacktrace) {
        add(GetMessageEvent(messageError: error.toString()));
        print(error.toString());
        print(stacktrace);
      });


      final resultGetPendingMessage = await _getMessageUserCase.invoke(NetworkState.HTTP1_PROTOCOL);
      final datas = await resultGetPendingMessage?.value3;

      datas?.map((data) =>
          add(GetMessageEvent(message: data))
      );



      //   retryOptions.retry(() async {
      //     await result?.listen((message) {
      //       add(GetMessageEvent(message: message));
      //     }).asFuture();
      //   },
      //       retryIf: (e) =>
      //           e is TimeoutException || e is WebSocketChannelException);
    } catch (err) {
      print(err.toString());
    }
  }

// @override
// Future<void> close() {
//   add(DisconnectSocketEvent());
//   return super.close();
// }
}
