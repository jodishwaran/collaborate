import 'dart:async';
import 'package:collaborate/model/event.dart';
import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/model/event_message.dart';
import 'package:collaborate/bloc/event_message_bloc.dart';
import 'package:collaborate/widget/event_detail.dart';
import 'package:collaborate/widget/message_item.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:flutter/material.dart';

class EventDetailPage extends StatefulWidget {
  static const pageName = '/event-detail';

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool _initDone = false;
  AuthBloc authBloc;
  EventMessageBloc eventMessageBloc;
  Event _event;

  StreamSubscription _eventMessagesSubscription;
  bool _loadingEventMessages = true;

  List<EventMessage> _eventMessages = [];

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (!_initDone) {
      authBloc = BlocProvider.of<AuthBloc>(context);
      eventMessageBloc = BlocProvider.of<EventMessageBloc>(context);
      _event = ModalRoute.of(context).settings.arguments as Event;

      eventMessageBloc.fetchEventMessages(_event.eventId, authBloc.token);
      _eventMessagesSubscription =
          eventMessageBloc.outMessages.listen((eventMessages) {
        setState(() {
          _eventMessages = eventMessages;
          _loadingEventMessages = false;
        });
      });
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
      body: Container(
          child: ListView(
        children: <Widget>[
          EventDetail(_event),
          _eventMessages.isEmpty
              ? Text("No message for this event...")
              : Container(
                  child: Column(
                    children: <Widget>[
                      Text('Messages:'),
                      Column(
                        children: _eventMessages.map((message) {
                          return MessageItem(message);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
        ],
      )),
    );
  }
}
