import 'package:get_it/get_it.dart';
import 'package:pkp_socket/core/network/dio_client.dart';
import 'package:pkp_socket/core/network/sse_client.dart';
import 'package:pkp_socket/core/network/sse_second_client.dart';
import 'package:pkp_socket/core/network/websocket_client.dart';
import 'package:pkp_socket/data/datasources/network/http/http_service.dart';
import 'package:pkp_socket/data/datasources/network/websocket/websocket.dart';
import 'package:pkp_socket/data/repositories/pkprepositoriesimpl.dart';
import 'package:pkp_socket/domain/repositories/pkprepositories.dart';
import 'package:pkp_socket/domain/usecase/ConnectConnectionUseCase.dart';
import 'package:pkp_socket/domain/usecase/DisconnectConnectionUseCase.dart';
import 'package:pkp_socket/domain/usecase/GetMessageUseCase.dart';
import 'package:pkp_socket/presentation/bloc/home/home_bloc.dart';
import 'package:pkp_socket/routes/routes_imports.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/src/channel.dart';

import '../core/network/api_provider.dart';
import '../data/datasources/network/sse/sse_service.dart';
import '../domain/usecase/SendMessageUseCase.dart';
import '../presentation/bloc/detail_message/detail_message_bloc.dart';

final getIt = GetIt.instance;

Future<void> setup() async {

  // Routes
  getIt.registerLazySingleton(() => AppRouter());

  // Client
  // getIt.registerSingleton<SseClient>(SseClientImpl());
  getIt.registerSingleton<SSESecondClient>(SSESecondClientImpl());
  getIt.registerLazySingleton(() => DioClient());

  // Service
  getIt.registerLazySingleton<PkpWebSocketService>(
      () => PkpWebSocketClientImpl(WebSocketClient.connect('jawa', '1')));
  getIt.registerLazySingleton<SseService>(() => SseServiceImpl(getIt()));
  getIt.registerLazySingleton<HttpService>(
      () => HttpServiceImpl(DioClient.connect()));

  // Repo
  getIt.registerSingleton<PkpRepositories>(PkpRepositoriesImpl(
        pkpWebSocketClient: getIt(),
        sseService: getIt(),
        httpService: getIt(),
      ));

  // Use case
  getIt.registerLazySingleton(() => GetMessageUseCase(getIt()));
  getIt.registerLazySingleton(() => SendMessageUseCase(getIt()));
  getIt.registerLazySingleton(() => DisconnectConnectionUseCase(getIt()));
  getIt.registerLazySingleton(() => ConnectConnectionUseCase(getIt()));

  // Bloc
  getIt.registerFactory(() => DetailMessageBloc(
        getMessageUserCase: getIt(),
        sendMessageUseCase: getIt(),
        disconnectConnectionUseCase: getIt(),
        connectConnectionUseCase: getIt(),
      ));

  getIt.registerFactory(() => HomeBloc(
        getMessageUseCase: getIt(),
      ));

  // IOWebSocketChannel.connect(
  //   ApiProvider.WEBSOCKET_BASE_URL +
  //       ApiProvider.GET_BY_USER_ID_AND_ROOM_S('jawa', '1'),
  //   pingInterval: const Duration(seconds: 5),
  //   connectTimeout: const Duration(seconds: 60),
  // )
}
