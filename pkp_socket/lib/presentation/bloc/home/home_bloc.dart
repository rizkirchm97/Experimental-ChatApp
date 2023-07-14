import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkp_socket/core/network/network_state.dart';
import 'package:pkp_socket/domain/usecase/GetMessageUseCase.dart';
import 'package:pkp_socket/presentation/bloc/home/home_event.dart';
import 'package:pkp_socket/presentation/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMessageUseCase _getMessageUseCase;

  HomeBloc({
    required GetMessageUseCase getMessageUseCase,
  })  : _getMessageUseCase = getMessageUseCase,
        super(HomeInitialState()) {
    on<GetPendingChatEvent>(_mapGetMessageToState);
    _init();
  }

  @override
  HomeState get state => HomeErrorState();


  Future<void> _mapGetMessageToState(GetPendingChatEvent event, Emitter<HomeState> emit) async {
    try {
      if (event.roomList != null) {
        emit(GetPendingMessageState(
          roomEntity: event.roomList));
      } else {
        emit(HomeErrorState(errorMessage: "You don't have any chat history"));
      }
    } catch (err) {
      print(err);
      emit(HomeErrorState(errorMessage: err.toString()));
    }
    
  }

  Future<void> _init() async {

    try {
      final result = await _getMessageUseCase.invoke(NetworkState.SSE_PROTOCOL);


      return await result?.value2?.listen((roomList) {
        add(GetPendingChatEvent(roomList: roomList));
      },
          onError: (error, stacktrace) {
            add(GetPendingChatEvent(responseMessage: stacktrace.toString()));
          }
      ).asFuture();
    }catch(err) {
      add(GetPendingChatEvent(responseMessage: err.toString()));
    }

  }
}
