import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pkp_socket/di/app_module.dart';
import 'package:pkp_socket/presentation/bloc/home/home_bloc.dart';
import 'package:pkp_socket/presentation/bloc/home/home_state.dart';
import 'package:pkp_socket/routes/routes_imports.dart';
import 'package:pkp_socket/routes/routes_imports.gr.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
      ),
      body: _buildBody(context),
    );
  }

  BlocProvider<HomeBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>(),
      lazy: false,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is GetPendingMessageState) {
            return _showListChatUser(context, state);
          } else if (state is HomeErrorState) {
            return Center(
              child: Text('${state.errorMessage}'),
            );
          } else {
            return const Center(
              child: Text('Other error occurred'),
            );
          }
        },
      ),
    );
  }

  Widget _showListChatUser(BuildContext context, HomeState state) {
    if (state is GetPendingMessageState) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          itemCount: state.roomEntity?.length,
          itemBuilder: (context, position) {
            return _itemList(context, position, state);
          },
        ),
      );
    } else {
      return const Center(
        child: Text('No Data'),
      );
    }
  }

  Widget _itemList(BuildContext context, int position, HomeState state) {
    if (state is GetPendingMessageState) {
      return Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(8),
            onTap: () => _goToDetailMessage(context, 'jawa', '${state.roomEntity![position].Room}'),
            title: Text(
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              '${state.roomEntity![position].Room_name}',
            ),
            subtitle: Text(
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              'Last Chat : ${DateTime.fromMillisecondsSinceEpoch(state.roomEntity![position].Last_sync_datetime! - DateTime.now().millisecondsSinceEpoch).minute} minutes ago',
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      );
    } else {
      return const Center(
        child: Text('No Data'),
      );
    }
  }

  _goToDetailMessage(BuildContext context, String userId, String roomId) {
    context.router.push(DetailMessagePageRoute(userId: userId, roomId: roomId));
  }
}
