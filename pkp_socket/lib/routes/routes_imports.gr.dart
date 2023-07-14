// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:pkp_socket/presentation/page/chat/chat_page.dart' as _i1;
import 'package:pkp_socket/presentation/page/detail_message/detail_message.dart'
    as _i2;
import 'package:pkp_socket/presentation/page/home/home_page.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    ChatPageRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ChatPage(),
      );
    },
    DetailMessagePageRoute.name: (routeData) {
      final args = routeData.argsAs<DetailMessagePageRouteArgs>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DetailMessagePage(
          key: args.key,
          userId: args.userId,
          roomId: args.roomId,
        ),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ChatPage]
class ChatPageRoute extends _i4.PageRouteInfo<void> {
  const ChatPageRoute({List<_i4.PageRouteInfo>? children})
      : super(
          ChatPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatPageRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DetailMessagePage]
class DetailMessagePageRoute
    extends _i4.PageRouteInfo<DetailMessagePageRouteArgs> {
  DetailMessagePageRoute({
    _i5.Key? key,
    required String userId,
    required String roomId,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          DetailMessagePageRoute.name,
          args: DetailMessagePageRouteArgs(
            key: key,
            userId: userId,
            roomId: roomId,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailMessagePageRoute';

  static const _i4.PageInfo<DetailMessagePageRouteArgs> page =
      _i4.PageInfo<DetailMessagePageRouteArgs>(name);
}

class DetailMessagePageRouteArgs {
  const DetailMessagePageRouteArgs({
    this.key,
    required this.userId,
    required this.roomId,
  });

  final _i5.Key? key;

  final String userId;

  final String roomId;

  @override
  String toString() {
    return 'DetailMessagePageRouteArgs{key: $key, userId: $userId, roomId: $roomId}';
  }
}

/// generated route for
/// [_i3.HomePage]
class HomePageRoute extends _i4.PageRouteInfo<void> {
  const HomePageRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomePageRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
