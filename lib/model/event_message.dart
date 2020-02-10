import 'package:flutter/foundation.dart';

class EventMessage {
  int threadId;
  String message;
  String userName;
  String postedAt;

  EventMessage(
      {@required this.threadId,
      @required this.message,
      @required this.userName,
      @required this.postedAt});

  static EventMessage fromJsonObject(dynamic jsonObject) {
    return EventMessage(
        threadId: jsonObject['threadId'],
        message: jsonObject['message'],
        userName: jsonObject['userName'],
        postedAt: jsonObject['postedAt']);
  }
}
