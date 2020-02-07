import 'dart:async';

import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/category_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/model/event.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:flutter/material.dart';

import 'event_list_item.dart';

class Dashboard extends StatefulWidget {
  Dashboard();

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _initDone = false;

  AuthBloc authBloc;
  EventBloc eventBloc;
  CategoriesBloc categoriesBloc;

  StreamSubscription _userCategoriesSubscription;
  StreamSubscription _userEventsSubscription;
  StreamSubscription _allEventsSubscription;
  StreamSubscription _userUpcomingEventsSubscription;

  bool _loadingUserOrganizedEvents = false;
  bool _loadingUserUpcomingEvents = false;

  List<Event> _userOrganizedEvents;
  List<Event> _allEvents = [];
  List<Event> _userUpcomingEvents;

  @override
  void didChangeDependencies() async {
    if (!_initDone) {
      authBloc = BlocProvider.of<AuthBloc>(context);
      eventBloc = BlocProvider.of<EventBloc>(context);
      categoriesBloc = BlocProvider.of<CategoriesBloc>(context);

      eventBloc.fetchUserEvents(authBloc.userId, authBloc.token);
      eventBloc.fetchAllEvents(authBloc.token);
      eventBloc.fetchUserUpcomingEvents(authBloc.userId, authBloc.token);

      _userEventsSubscription =
          eventBloc.outOrganizedEvents.listen((userOrganizedEvents) {
        _userOrganizedEvents = userOrganizedEvents;
        _userOrganizedEvents.sort((a, b) {
          var adate = a.eventStartTime;
          var bdate = b.eventStartTime;
          return bdate.compareTo(adate);
        });
        setState(() {
          _userOrganizedEvents = _userOrganizedEvents;
          _loadingUserOrganizedEvents = false;
        });
      });

      _allEventsSubscription = eventBloc.outAllEvents.listen((allEvents) {
        setState(() {
          _allEvents = allEvents;
        });
      });

      _userUpcomingEventsSubscription =
          eventBloc.outSubscribedEvents.listen((userUpcomingEvents) {
        setState(() {
          _userUpcomingEvents = userUpcomingEvents;
          _loadingUserUpcomingEvents = false;
        });
      });
    }
    _initDone = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final EventBloc featuredEventsProvider =
        BlocProvider.of<EventBloc>(context);

    return Container(
      height: 600.0,
      constraints: BoxConstraints(maxHeight: 600.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.symmetric(horizontal: 10.0),
//                child: Text(
//                  'You have not organized any Events coming up. Please create one!',
//                  style: TextStyle(
//                    fontFamily: Theme.of(context).textTheme.body1.fontFamily,
//                  ),
//                ),
//              ),
//              RaisedButton(
//                  child: Text('Create Event'),
//                  onPressed: () {
//                    Navigator.of(context).pushNamed(CreateEventPage.pageName);
//                  }),
//              Divider(),
//              Text(
//                'Top Events for You!',
//                style: Theme.of(context).textTheme.title,
//              ),
              Container(
                height: 600,
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      bottom: TabBar(
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Created',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Icon(Icons.assessment)
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Upcoming',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Icon(Icons.play_for_work)
                              ],
                            ),
                          ),
                        ],
                      ),
                      title: Center(child: Text('Events')),
                    ),
                    body: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _userOrganizedEvents == null
                              ? Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                )
                              : _userOrganizedEvents.isNotEmpty
                                  ? ListView(
//                                  crossAxisAlignment:
//                                      CrossAxisAlignment.stretch,
                                      children: _userOrganizedEvents
                                          .map((Event featuredEvent) {
                                      return EventListItem(
                                          event: featuredEvent);
                                    }).toList())
                                  : Center(
                                      child: Text(
                                          'You have not organized any events'),
                                    ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _userUpcomingEvents == null
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  )
                                : _userUpcomingEvents.isNotEmpty
                                    ? ListView(
//                                  crossAxisAlignment:
//                                      CrossAxisAlignment.stretch,
                                        children: _userUpcomingEvents
                                            .map((Event featuredEvent) {
                                        return EventListItem(
                                            event: featuredEvent);
                                      }).toList())
                                    : Center(
                                        child: Text(
                                            'You have not subscribed to any events'),
                                      ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_userEventsSubscription != null) {
      _userEventsSubscription.cancel();
    }
    if (_userCategoriesSubscription != null) {
      _userCategoriesSubscription.cancel();
    }
    if (_allEventsSubscription != null) {
      _allEventsSubscription.cancel();
    }
    if (_userUpcomingEventsSubscription != null) {
      _userUpcomingEventsSubscription.cancel();
    }

    super.dispose();
  }
}
