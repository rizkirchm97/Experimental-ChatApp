import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pkp_socket/core/constants.dart';
import 'package:pkp_socket/core/network/network_state.dart';
import 'package:pkp_socket/data/repositories/pkprepositoriesimpl.dart';
import 'package:pkp_socket/di/app_module.dart';
import 'package:pkp_socket/domain/entities/message_entity.dart';
import 'package:pkp_socket/domain/repositories/pkprepositories.dart';
import 'package:pkp_socket/presentation/bloc/detail_message/detail_message_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pkp_socket/di/app_module.dart' as di;

import '../../presentation/bloc/detail_message/detail_message_bloc.dart';

class NotificationForegroundService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeService() async {
    final service = FlutterBackgroundService();
    // await di.setup();
    // final repo = getIt<PkpRepositories>();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id',
      'Channel Name',
      description: 'Channel Description',
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: 'channel_id',
        foregroundServiceNotificationId: 1,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
      ),
    );

    service.startService();

    // Run your WebSocket connection code here
    // Assuming you have a WebSocket stream called 'webSocketStream'
    // final resultConnectionState = await repo.onMessage(NetworkState.WEBSOCKET_PROTOCOL);
    // handleWebSocketMessages(resultConnectionState?.value1 as Stream);
  }

  static Future<void> _onStart(ServiceInstance serviceInstance) async {
    await di.setup();
    final repo = getIt<PkpRepositories>();
    // Initialize the FlutterLocalNotificationsPlugin and configure the notification channel
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Run your WebSocket connection code here
    // Assuming you have a WebSocket stream called 'webSocketStream'
    final resultConnectionState =
        await repo.onMessage(NetworkState.WEBSOCKET_PROTOCOL);
    handleWebSocketMessages(resultConnectionState?.value1 as Stream);
  }

  static void handleWebSocketMessages(Stream<dynamic> stream) {
    stream.listen((data) {
      final res = data as MessageEntity;
      // final userId = data['userId'];
      // final message = data['message'];

      showNotification('New Message', '${res.userId}: ${res.message}');
    });
  }

  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel_id', 'Channel Name',
            channelDescription: 'Channel Description',
            showWhen: false,
            ongoing: false,
            importance: Importance.min,
            priority: Priority.low);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
