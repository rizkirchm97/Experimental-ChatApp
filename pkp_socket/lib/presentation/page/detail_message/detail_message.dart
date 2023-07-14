import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pkp_socket/di/app_module.dart';
import '../../bloc/detail_message/detail_message_bloc.dart';
import '../../bloc/detail_message/detail_message_state.dart';
import '../../widget/input_and_send_widget.dart';

@RoutePage()
class DetailMessagePage extends StatefulWidget {
  late final String _userId;
  late final String _roomId;

  DetailMessagePage({
    Key? key,
    required String userId,
    required String roomId,
  }) : super(key: key) {
    _userId = userId;
    _roomId = roomId;
  }

  String get roomId => _roomId;

  String get userId => _userId;

  @override
  State<DetailMessagePage> createState() => _DetailMessagePageState();
}

class _DetailMessagePageState extends State<DetailMessagePage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController.value = 1.0;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } else {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(microseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.blue, // Replace with your desired color
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("WebSocket Client"),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<DetailMessageBloc> buildBody(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => getIt<DetailMessageBloc>(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: BlocConsumer<DetailMessageBloc, DetailMessageState>(
              builder: (context, state) {
                if (state is MessageReceivedState) {
                  return _showList(context, state);
                } else if (state is Error) {
                  return const Center(
                    child: Text('Error occurred'),
                  );
                } else if (state is Loading) {
                  return const Center(
                    child: Text(
                      'Loading...',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Lets chat your thought\n Type something interest to your friend',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
              listener: (context, state) {},
            ),
          ),
          InputAndSendWidget(
            userId: widget.userId,
            roomId: widget.roomId,
          )
        ],
      ),
    );
  }

  Widget _showList(BuildContext context, DetailMessageState state) {
    if (state is MessageReceivedState) {
      return ListView.builder(
        padding: const EdgeInsets.all(20),
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: state.message?.length,
        itemBuilder: (context, position) {
          return _itemList(context, position, state);
        },
      );
    }

    return const Center(
      child: Text('No messages'),
    );
  }

  Widget _itemList(
      BuildContext context, int position, MessageReceivedState state) {
    if (state.message![position].userId != "jawa") {
      return Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width - 300,
              maxWidth: MediaQuery.of(context).size.width - 45),
          child: Card(
              margin: const EdgeInsets.only(bottom: 15),
              color: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message![position].userId as String,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      state.message![position].message as String,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              )),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width - 300,
              maxWidth: MediaQuery.of(context).size.width - 45),
          child: Card(
              margin: const EdgeInsets.only(bottom: 15),
              color: Colors.blue.shade200,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message![position].userId as String,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      state.message![position].message as String,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              )),
        ),
      );
    }
  }
}
