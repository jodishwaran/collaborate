import 'package:flutter/foundation.dart';

enum EventStatus { Created, Started, Completed, Canceled }

class Event {
  int eventId;
  String eventName;
  String eventDesc;
  String status;
  int userId;
  DateTime eventStartTime;
  DateTime eventEndTime;
  String eventLocation;
  int minPeople;
  int maxPeople;
  int categoryId;
  int locationId;

  Event({
    @required this.eventId,
    @required this.eventName,
    @required this.eventDesc,
    @required this.status,
    @required this.userId,
    @required this.eventStartTime,
    @required this.eventEndTime,
    @required this.eventLocation,
    @required this.minPeople,
    @required this.maxPeople,
    @required this.categoryId,
    @required this.locationId,
  });
}
