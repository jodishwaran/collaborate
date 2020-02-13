import 'package:collaborate/model/event_message.dart';
import 'package:collaborate/widget/message_item.dart';
import 'package:flutter/material.dart';

class EventMessages extends StatefulWidget {
  final List<EventMessage> _eventMessages;

  EventMessages(this._eventMessages);
  @override
  _EventMessagesState createState() => _EventMessagesState();
}

class _EventMessagesState extends State<EventMessages> {
//  bool _initDone = false;
//  AuthBloc authBloc;
//  EventMessageBloc eventMessageBloc;
//  Event _event;

//  StreamSubscription _eventMessagesSubscription;
//  bool _loadingEventMessages = true;

  @override
  void didChangeDependencies() async {
//    if (!_initDone) {
//      authBloc = BlocProvider.of<AuthBloc>(context);
//      eventMessageBloc = BlocProvider.of<EventMessageBloc>(context);
//
//      _event = ModalRoute.of(context).settings.arguments as Event;
//
//      eventMessageBloc.fetchEventMessages(_event.eventId, authBloc.token);
//      _eventMessagesSubscription =
//          eventMessageBloc.outMessages.listen((eventMessages) {
//        setState(() {
//          _eventMessages = eventMessages;
//          _loadingEventMessages = false;
//        });
//      });
//    }

//    _initDone = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
//      decoration: BoxDecoration(
//        border: Border.all(color: Colors.black54),
//      ),
//      width: double.infinity,
      child: Column(
        children: widget._eventMessages.map((message) {
          return MessageItem(message);
        }).toList(),
      ),
    );
  }

  @override
  void deactivate() {
//    _eventMessagesSubscription.cancel();
    super.deactivate();
  }
}
