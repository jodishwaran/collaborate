import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/model/event.dart';
import 'package:collaborate/util/constants.dart';
import 'package:collaborate/util/resources.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'event_request_list.dart';

class EventDetail extends StatefulWidget {
  final Event event;

  EventDetail(this.event);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final String imgURL =
      'https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60%20100w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=60%20200w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=60%20300w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60%20400w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60%20500w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60%20600w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60%20700w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60%20800w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60%20900w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60%201000w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=60%201100w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1200&q=60%201200w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60%201296w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60%201400w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=60%201600w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1800&q=60%201800w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2000&q=60%202000w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2048&q=60%202048w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2048&q=60%202048w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2048&q=60%202048w';

  AuthBloc _authBloc;
  EventBloc _eventBloc;
  bool _isLoading = false;
  bool isRequestBtnDisabled = false;

  Widget _buildLabel(BuildContext context, String labelText) {
    return Expanded(
      flex: 1,
      child: ListTile(
        title: Text(labelText,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildEventDetailItem(
      BuildContext context, String data, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          _buildLabel(context, labelText),
          Expanded(
            child: Text(data),
            flex: 2,
          )
        ],
      ),
    );
  }

  bool get _isUserTheEventOwner {
    return widget.event != null && widget.event.userId == _authBloc.userId;
  }

  _handleAttendEvent() async {
    setState(() {
      _isLoading = true;
    });
    final payload = {
      "userId": _authBloc.userId,
      "eventId": widget.event.eventId
    };

    SnackBar snackbar = kSnackBar('Event Join request has been sent');
    try {
      await _eventBloc.attendEvent(payload, _authBloc.token);
      setState(() {
        _isLoading = false;
        isRequestBtnDisabled = true;
      });

      Scaffold.of(context).showSnackBar(snackbar);
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      print('error while approve event - ${widget.event.eventId} - $err');
    }
  }

  _buildEventActionButton(String labelText, Function handler) {
    return RaisedButton(
      child: Text(isRequestBtnDisabled ? 'Request Sent!' : labelText),
      onPressed: isRequestBtnDisabled ? null : handler,
    );
  }

  bool _initDone = false;
  @override
  void didChangeDependencies() {
    if (!_initDone) {
      _authBloc = BlocProvider.of<AuthBloc>(context);
      _eventBloc = BlocProvider.of<EventBloc>(context);
    }
    _initDone = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 600,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(imgURL),
                radius: 50.0,
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildEventDetailItem(
                        context, widget.event.eventId.toString(), 'Event Id'),
                    _buildEventDetailItem(
                        context, widget.event.eventName, 'Event name'),
                    _buildEventDetailItem(
                        context, widget.event.eventDesc, 'Event description'),
                    _buildEventDetailItem(
                        context,
                        DateFormat.yMd()
                            .add_jms()
                            .format(widget.event.eventStartTime),
                        'From'),
                    _buildEventDetailItem(
                        context,
                        DateFormat.yMd()
                            .add_jms()
                            .format(widget.event.eventEndTime),
                        'To'),
                    _isLoading
                        ? CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor,
                          )
                        : Container(),
                    _isUserTheEventOwner
                        ? Container()
                        : _buildEventActionButton(
                            ContentString.attend_create, _handleAttendEvent)
                  ],
                ),
              ),
              _isUserTheEventOwner
                  ? EventRequestList(widget.event.eventId)
//                  ? Container(
//                      height: 600,
//                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

//_buildLabel(context, 'Event Description'),
//_buildLabel(context, 'From'),
//_buildLabel(context, 'To'),
//_buildLabel(context, 'Organized By'),
