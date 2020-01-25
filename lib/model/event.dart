import 'package:flutter/foundation.dart';

enum EventStatus { Scheduled, Started, Completed, Canceled }

class Event {
  String id;
  String title;
  String description;
  EventStatus status;
  String createdBy;
  DateTime startDate;
  DateTime endDate;

  Event({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.status,
    @required this.createdBy,
    @required this.startDate,
    @required this.endDate,
  });
}
