Future<String> generateMessageId({String? userId, String? roomId}) async {

  final stringBuffer = StringBuffer();
  final dateTime = DateTime.now().millisecondsSinceEpoch;

  final List<String> resultJoin = await Future.value(["$userId", "$roomId", "$dateTime"]);
  stringBuffer.writeAll(resultJoin);

  return stringBuffer.toString();
}
