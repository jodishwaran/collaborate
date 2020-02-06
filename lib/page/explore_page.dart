import 'dart:async';

import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/model/event.dart';
import 'package:collaborate/page/event_detail_page.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  static final pageName = '/explore';
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  AuthBloc authBloc;
  EventBloc eventBloc;

  bool _initDone = false;
  List<Event> _allEvents = [];

  StreamSubscription _allEventsSubscription;

  @override
  void didChangeDependencies() async {
    if (!_initDone) {
      authBloc = BlocProvider.of<AuthBloc>(context);
      eventBloc = BlocProvider.of<EventBloc>(context);

      eventBloc.fetchAllEvents(authBloc.token);

      _allEventsSubscription = eventBloc.outAllEvents.listen((allEvents) {
        setState(() {
          _allEvents = allEvents;
        });
      });
    }
    _initDone = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Center(
              child: Text(
                'Explore Events happening around',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 20),
              ),
            ),
          ),
          Container(
            child: Column(
              children: _allEvents.map((event) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(EventDetailPage.pageName,
                          arguments: event);
                    },
                    leading: Text(event.eventName),
                    title: Center(child: Text(event.eventDesc)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    _allEventsSubscription.cancel();
    // TODO: implement deactivate
    super.deactivate();
  }
}
