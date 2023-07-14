import 'package:equatable/equatable.dart';

class RoomModel {
  String? _id;
  String? _Room;
  String? _Room_name;
  String? _Room_type;
  List<dynamic>? _Members;
  int? _Created_datetime;
  int? _Updated_datetime;
  int? _Last_sync_datetime;

  RoomModel({
    String? id,
    String? Room,
    String? Room_name,
    String? Room_type,
    List<dynamic>? Members,
    int? Created_datetime,
    int? Updated_datetime,
    int? Last_sync_datetime,
  }) {
    _id = id;
    _Room = Room;
    _Room_name = Room_name;
    _Room_type = Room_type;
    _Members = Members;
    _Created_datetime = Created_datetime;
    _Updated_datetime = Updated_datetime;
    _Last_sync_datetime = Last_sync_datetime;
  }

  String? get id => _id;

  String? get Room => _Room;

  String? get Room_name => _Room_name;

  String? get Room_type => _Room_type;

  List<dynamic>? get Members => _Members;

  int? get Created_datetime => _Created_datetime;

  int? get Updated_datetime => _Updated_datetime;

  int? get Last_sync_datetime => _Last_sync_datetime;

  RoomModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _Room = json['room'];
    _Room_name = json['room_name'];
    _Room_type = json['room_type'];
    _Members = List<dynamic>.from(json['members']);
    _Created_datetime = json['created_datetime'];
    _Updated_datetime = json['updated_datetime'];
    _Last_sync_datetime = json['last_sync_datetime'];
  }

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['id'] = _id;
    map['room'] = _Room;
    map['room_name'] = _Room_name;
    map['room_type'] = _Room_type;
    map['members'] = _Members;
    map['created_datetime'] = _Created_datetime;
    map['updated_datetime'] = _Updated_datetime;
    map['last_sync_datetime'] = _Last_sync_datetime;
    return map;
  }
}
