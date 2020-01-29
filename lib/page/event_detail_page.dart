import 'package:collaborate/model/event.dart';
import 'package:collaborate/widget/event_detail.dart';
import 'package:flutter/material.dart';

class EventDetailPage extends StatefulWidget {
  static const pageName = '/event-detail';

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool _initDone = false;
  Event _event;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_initDone) {
      _event = ModalRoute.of(context).settings.arguments as Event;
    }

    _initDone = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('${_event.eventName} Detail'),
        ),
      ),
      body: EventDetail(_event),
    );
  }
}
