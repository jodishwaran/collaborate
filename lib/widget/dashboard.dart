import 'dart:async';

import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/category_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/model/event.dart';
import 'package:collaborate/util/constants.dart';
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
          return adate.compareTo(bdate);
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

  List<Event> get getUserOrganizedEventsForToday {
    if (_userOrganizedEvents == null || _userOrganizedEvents.isEmpty) {
      return null;
    }

    return _userOrganizedEvents.where((events) {
      return calculateDateDifference(events.eventStartTime) == 0;
    }).toList();

//    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
//    print(x.length);
//    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

//    return x;
  }

  List<Event> get getUserOrganizedFutureEvents {
    if (_userOrganizedEvents == null || _userOrganizedEvents.isEmpty) {
      return null;
    }

    return _userOrganizedEvents.where((events) {
      return calculateDateDifference(events.eventStartTime) > 0;
    }).toList();

//    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
//    print(x.length);
//    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
//    return x;
  }

  List<Event> get getJoinedEventsToday {
    if (_userUpcomingEvents == null || _userUpcomingEvents.isEmpty) {
//      print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
//      print('Null getJoinedEventsToday');
//      print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
      return null;
    }

    final x = _userUpcomingEvents.where((events) {
      return calculateDateDifference(events.eventStartTime) == 0;
    }).toList();

//    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
//    print('its there getJoinedEventsToday');
//    print(x);
//    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

    return x;
  }

  List<Event> get getJoinedFutureEvents {
    if (_userUpcomingEvents == null || _userUpcomingEvents.isEmpty) {
      return null;
    }

    return _userUpcomingEvents.where((events) {
      return calculateDateDifference(events.eventStartTime) > 0;
    }).toList();
  }

  Widget _buildDateHeaderContainer(String text, List<Event> events) {
    return events.isNotEmpty
        ? Container(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0XFF29323c),
                Color(0XFF485563),
              ]),
              color: Colors.black,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            width: double.infinity,
//            decoration: BoxDecoration(
//              border: Border(
//                bottom: BorderSide(
//                  color: Colors.black87,
//                  width: 3.0,
//                ),
//              ),
//            ),
            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.event,
                  color: Colors.white,
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _buildEventList(List<Event> events, String emptyText) {
    return Column(
      children: events == null
          ? [Text(emptyText)]
          : events.map((Event featuredEvent) {
              return EventListItem(event: featuredEvent);
            }).toList(),
    );
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
                                  'Requested',
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
                      title: Center(child: Text('My Events')),
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
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            (getUserOrganizedEventsForToday !=
                                                        null ||
                                                    getUserOrganizedEventsForToday
                                                            .length !=
                                                        0)
                                                ? _buildDateHeaderContainer(
                                                    'Today',
                                                    getUserOrganizedEventsForToday)
                                                : SizedBox(),
                                            _buildEventList(
                                                getUserOrganizedEventsForToday,
                                                'No organized events for Today!'),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            (getUserOrganizedFutureEvents !=
                                                        null ||
                                                    getUserOrganizedFutureEvents
                                                            .length !=
                                                        0)
                                                ? _buildDateHeaderContainer(
                                                    'Upcoming',
                                                    getUserOrganizedFutureEvents)
                                                : SizedBox(),
                                            _buildEventList(
                                                getUserOrganizedFutureEvents,
                                                ''),
                                          ],
                                        ),
                                      ],
                                    )
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
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              (getJoinedEventsToday != null ||
                                                      getJoinedEventsToday
                                                              .length >
                                                          0)
                                                  ? _buildDateHeaderContainer(
                                                      'Today',
                                                      getJoinedEventsToday)
                                                  : Container(),
                                              _buildEventList(
                                                  getJoinedEventsToday,
                                                  'You don\'t have events to attend today!'),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              (getJoinedFutureEvents != null ||
                                                      getJoinedFutureEvents
                                                              .length !=
                                                          0)
                                                  ? _buildDateHeaderContainer(
                                                      'Upcoming',
                                                      getJoinedFutureEvents)
                                                  : SizedBox(),
                                              _buildEventList(
                                                  getJoinedFutureEvents, ''),
                                            ],
                                          ),
                                        ],
                                      )
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

//ListView(
//children: _userUpcomingEvents
//    .map((Event featuredEvent) {
//return EventListItem(
//event: featuredEvent);
//}).toList())
