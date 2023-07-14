import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:pkp_socket/core/network/api_provider.dart';
import 'package:pkp_socket/data/datasources/model/message_model.dart';

abstract class SSESecondClient {
  Stream<String?> onMessage(String url);
}

class SSESecondClientImpl extends SSESecondClient {
  @override
  Stream<String?> onMessage(String url) async* {
    final baseUrl = ApiProvider.BASE_URL;
    yield* SSEClient.subscribeToSSE(
      url: baseUrl + url,
      header: {
        "Accept": "text/event-stream",
        "Cache-Control": "no-cache",
      },
    ).map((event) {
      print('SSE Second client: ${event.data.toString()}');

      return event.data;
    }


    );
  }
}
