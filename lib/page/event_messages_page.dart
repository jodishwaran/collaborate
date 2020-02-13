import 'dart:async';

import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/event_message_bloc.dart';
import 'package:collaborate/model/event.dart';
import 'package:collaborate/model/event_message.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:collaborate/widget/event_messages.dart';
import 'package:flutter/material.dart';

class EventMessagesPage extends StatefulWidget {
  static final pageName = "/event_messages";

  @override
  _EventMessagesPageState createState() => _EventMessagesPageState();
}

class _EventMessagesPageState extends State<EventMessagesPage> {
  bool _initDone = false;
  AuthBloc authBloc;
  EventMessageBloc eventMessageBloc;
  Event _event;

  StreamSubscription _eventMessagesSubscription;
  bool _loadingEventMessages = true;

  List<EventMessage> _eventMessages = [];
  @override
  void didChangeDependencies() async {
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.message),
            SizedBox(
              width: 10,
            ),
            Text('Messages'),
          ],
        ),
      ),
      body: _loadingEventMessages
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : _eventMessages.isEmpty
              ? Center(
                  child: Text('No messages for this Event'),
                )
              : ListView(
                  children: [
                    EventMessages(_eventMessages),
                  ],
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                ),
    );
  }

  @override
  void deactivate() {
    _eventMessagesSubscription.cancel();
    super.deactivate();
  }
}
