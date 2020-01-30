import 'package:collaborate/util/constants.dart';
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
  String userRequestedStatus;

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

  Event.fromJson(Map<String, dynamic> json)
      : eventId = json['eventId'],
        eventName = json['eventName'],
        eventDesc = json['eventDesc'],
        status = json['status'],
        userId = json['userId'],
        eventStartTime = parseDateString(json['eventStartTime']),
        eventEndTime = parseDateString(json['eventEndTime']),
        minPeople = json['minPeople'],
        maxPeople = json['maxPeople'],
        categoryId = json['categoryId'],
        locationId = json['locationId'];

  Event.fromServerlessJson(Map<String, dynamic> json)
      : eventId = json['event_id'],
        eventName = json['event_name'],
        eventDesc = json['event_desc'],
        status = json['status'],
        userId = json['user_id'],
        eventStartTime = DateTime.now().add(Duration(days: 1)),
        eventEndTime = DateTime.now().add(Duration(days: 2, hours: 1)),
//        eventStartTime = parseDateString(json['event_start_time']),
//        eventEndTime = parseDateString(json['event_end_time']),
        minPeople = json['min_people'],
        maxPeople = json['max_people'],
        categoryId = json['category_id'],
        locationId = json['location_id'],
        userRequestedStatus = json['event_req_status'];
}
