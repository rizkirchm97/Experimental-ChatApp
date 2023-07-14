import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class CustomHttpClientAdapter implements HttpClientAdapter {


  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    final ioClient = HttpClient();
    ioClient.badCertificateCallback = (cert, host, port) => true;

    final uri = options.uri;
    final request = await ioClient.openUrl(options.method, uri);

    options.headers.forEach((key, value) {
      request.headers.set(key, value);
    });

    if (requestStream != null) {
      await request.addStream(requestStream);
    }

    final response = await request.close();


    final headers = <String, List<String>>{};
    response.headers.forEach((name, values) {
      headers[name] = List<String>.from(values);
    });

    final bodyChunks = <Uint8List>[];
    await response.forEach((chunk) {
      bodyChunks.add(Uint8List.fromList(chunk));
    });

    final responseBody = Stream<Uint8List>.fromIterable(bodyChunks);

    return ResponseBody(
      responseBody,
      response.statusCode,
      headers: headers,
      statusMessage: await response.transform(utf8.decoder).join(),
    );

  }

  @override
  void close({bool force = false}) {
  }


}