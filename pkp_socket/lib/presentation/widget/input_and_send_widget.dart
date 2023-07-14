import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/detail_message/detail_message_bloc.dart';
import '../bloc/detail_message/detail_message_event.dart';

class InputAndSendWidget extends StatefulWidget {
  late final String _userId;
  late final String _roomId;

  InputAndSendWidget({
    Key? key,
    required String userId,
    required String roomId,
  }) : super(key: key){
    _userId = userId;
    _roomId = roomId;
  }

  String get roomId => _roomId;
  String get userId => _userId;

  @override
  State<InputAndSendWidget> createState() => _InputAndSendWidgetState();
}

class _InputAndSendWidgetState extends State<InputAndSendWidget> {
  final messageController = TextEditingController();
  String? message;
  late DetailMessageBloc _detailMessageBloc;

  @override
  void initState() {
    super.initState();
    _detailMessageBloc = BlocProvider.of<DetailMessageBloc>(context);
    _detailMessageBloc.add(ConnectSocketEvent(
      userId: widget.userId,
      roomId: widget.roomId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              textAlign: TextAlign.start,
              onChanged: (value) {
                setState(() {
                  message = value;
                });
              },
              onSubmitted: (_) {
                sendMessage();
              },
              // onTap: _connect(),
              controller: messageController,
              textInputAction: TextInputAction.send,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Type a message",
                filled: true,
                fillColor: Colors.grey.shade200,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: sendMessage,
            child: const Text("Kirim"),
          ),
        ],
      ),
    );
  }

  void sendMessage() {
    messageController.clear();
    BlocProvider.of<DetailMessageBloc>(context)
        .add(SendMessageEvent(message: message));
  }

  @override
  void dispose() {
    _detailMessageBloc.add(DisconnectSocketEvent());
    super.dispose();
  }

// void _connect() {
//   BlocProvider.of<DetailMessageBloc>(context).add(ConnectSocketEvent());
// }
}
