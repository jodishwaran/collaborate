import 'dart:async';

import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/model/event_request.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:collaborate/widget/event_detail_requests_tab.dart';
import 'package:flutter/material.dart';

class EventRequestList extends StatefulWidget {
  final int eventId;

  EventRequestList(this.eventId);
  @override
  _EventRequestListState createState() => _EventRequestListState();
}

class _EventRequestListState extends State<EventRequestList> {
  bool _initDone = false;

  AuthBloc _authBloc;
  EventBloc _eventBloc;

  StreamSubscription _requestSubscription;

  List<EventRequest> _requestListForEvent;
  bool _isLoading = false;
  bool _isRequestApproving = false;

  @override
  void didChangeDependencies() async {
    if (!_initDone) {
      _authBloc = BlocProvider.of<AuthBloc>(context);
      _eventBloc = BlocProvider.of<EventBloc>(context);
      _isLoading = true;

      _requestSubscription = _eventBloc.outRequestedEvents.listen((requests) {
        _requestListForEvent = requests;

        print('requests for events');
        print(_requestListForEvent);

        setState(() {
          _isLoading = false;
        });
      });

      try {
        await _eventBloc.fetchRequestsByEvent(widget.eventId, _authBloc.token);
//        setState(() {
//          _isLoading = false;
//        });
      } catch (err) {
        setState(() {
          _isLoading = false;
        });
      }
    }
    _initDone = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_requestListForEvent == null) {
      return Center(
          child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor));
    } else {
      return _requestListForEvent.isEmpty
          ? Container()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(''),
                EventDetailRequestsTab(_requestListForEvent),
              ],
            );
    }
  }

//  Flexible(
//  child: ListView.separated(
//  separatorBuilder: (BuildContext context, int index) =>
//  Divider(),
//  scrollDirection: Axis.vertical,
//  shrinkWrap: true,
//  itemBuilder: (BuildContext context, int index) {
//  return ListTile(
//  title: Text(_requestListForEvent[index].userName),
//  );
//  },
//  itemCount: _requestListForEvent.length,
//  ),
//  )

  @override
  void dispose() {
    if (_requestSubscription != null) {
      _requestSubscription.cancel();
    }
    super.dispose();
  }
}
