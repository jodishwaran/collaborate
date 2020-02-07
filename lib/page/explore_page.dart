import 'dart:async';

import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/model/event.dart';
import 'package:collaborate/page/event_detail_page.dart';
import 'package:collaborate/util/constants.dart';
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
    return Column(
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
        Expanded(
          child: Container(
              child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final event = _allEvents[index];
              return Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            event.eventName,
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                formatDate(event.eventStartTime).toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                formatTime(event.eventStartTime).toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff000428),
                            Color(0xff004e92),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.black54,
                          ),
                          right: BorderSide(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(event.eventDesc),
                              ),
                              CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage('https://picsum.photos/200'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        textTheme:
                            TextTheme(title: TextStyle(color: Colors.white)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffcccccc),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(10.0, 5.0),
                            bottomRight: Radius.elliptical(10.0, 5.0),
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.people,
                                          color: Colors.black87,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'Min',
                                          style: TextStyle(
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          event.minPeople.toString(),
                                          style: TextStyle(
                                            color: Colors.black87,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Row(
                                    children: <Widget>[
                                      Icon(Icons.people, color: Colors.black87),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        'Max',
                                        style: TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        event.maxPeople.toString(),
                                        style: TextStyle(
                                          color: Colors.black87,
                                        ),
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Ends:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                              formatDate(event.eventEndTime)
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black87,
                                              )),
                                          Text(
                                              formatTime(event.eventEndTime)
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black87,
                                              )),
                                          SizedBox(
                                            width: 70,
                                          ),
                                          FlatButton(
                                            child: Text('view more'),
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  EventDetailPage.pageName,
                                                  arguments: event);
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: _allEvents.length,
          )),
        ),
      ],
    );
  }

  @override
  void deactivate() {
    _allEventsSubscription.cancel();
    // TODO: implement deactivate
    super.deactivate();
  }
}
