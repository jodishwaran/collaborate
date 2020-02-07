import 'package:flutter/foundation.dart';

class EventRequest {
  int requestId;
  int userId;
  String userName;
  String status;
  String statusId;
  int eventId;

  EventRequest({
    @required this.requestId,
    @required this.userId,
    @required this.userName,
    @required this.status,
    @required this.eventId,
    this.statusId,
  });

  EventRequest.fromJson(Map<String, dynamic> json)
      : eventId = json['eventId'],
        requestId = json['requestId'],
        userName = json['userName'],
        status = json['status'],
        userId = json['userId'];
}
