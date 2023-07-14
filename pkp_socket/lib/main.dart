import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pkp_socket/core/service/notification_foreground_service.dart';
import 'package:pkp_socket/presentation/page/chat/chat_page.dart';
import 'package:pkp_socket/presentation/page/detail_message/detail_message.dart';
import 'package:pkp_socket/routes/routes_imports.dart';
import 'di/app_module.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setup();
  await NotificationForegroundService.initializeService();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = di.getIt<AppRouter>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
