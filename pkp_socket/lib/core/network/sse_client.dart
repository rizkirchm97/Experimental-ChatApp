import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:pkp_socket/core/network/api_provider.dart';

abstract class SseClient {
  Stream<dynamic> connect(String endPoint);
}

class SseClientImpl extends SseClient {
  @override
  Stream<dynamic> connect(String endPoint) async* {
    final client = HttpClient();
    final uriBaseUrl = Uri.parse(ApiProvider.BASE_URL);
    final mergedUri = await Future.value(uriBaseUrl.resolve(endPoint));

    final response =
        await client.getUrl(mergedUri).then((HttpClientRequest request) {
      request.headers.set('Accept', 'text/event-stream');

      return request.close();
    });


    if (response.statusCode == HttpStatus.ok) {
      var buffer = StringBuffer();
      await for (var chunk in response.transform(utf8.decoder)) {
        final data = chunk.trim();
        if (data.isEmpty) continue; // Skip empty lines

        if (data.startsWith('event:')) {
          // Handle event field
          final event = data.substring(6).trim();
          buffer.clear();
          buffer.writeln('event:$event');
        } else if (data.startsWith('data:')) {
          // Handle data field
          final jsonData = buffer.toString() + data.substring(5).trim();
          buffer.clear();
          try {
            final decodedData = jsonDecode(jsonData);
            yield decodedData;
          } catch (e) {
            print('Failed to decode JSON: $e');
          }
        } else {
          buffer.writeln(data);
        }
      }
    } else {
      throw Exception('Failed to connect to SSE endpoint.');
    }

    // final jsonData = jsonDecode(response as String);
    //
    // if (jsonData is List) {
    //   yield* Stream.fromIterable(jsonData as Iterable<String>);
    // } else {
    //   yield jsonData;
    // }
  }
}


//     .then((HttpClientResponse response) {
// if (response.statusCode == HttpStatus.ok) {
// print('response : ${response.transform(utf8.decoder).join()}');
// return response.transform(utf8.decoder).join();
// } else {
// throw Exception('Failed to connect to SSE endpoint.');
// }
// });
