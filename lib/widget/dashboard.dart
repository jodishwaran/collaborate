import 'dart:async';

import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/category_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/model/event.dart';
import 'package:collaborate/page/create_event_page.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:collaborate/widget/event_list_item.dart';
import 'package:flutter/material.dart';

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

  StreamSubscription userCategoriesSubscription;

  @override
  void didChangeDependencies() {
    if (_initDone) {
      authBloc = BlocProvider.of<AuthBloc>(context);
      eventBloc = BlocProvider.of<EventBloc>(context);
      categoriesBloc = BlocProvider.of<CategoriesBloc>(context);

//      categoriesBloc.outUserCategories.listen((){
//
//      })

      eventBloc.fetchUserEvents(authBloc.userId, authBloc.token);
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'You have not organized any Events coming up. Please create one!',
                  style: TextStyle(
                    fontFamily: Theme.of(context).textTheme.body1.fontFamily,
                  ),
                ),
              ),
              RaisedButton(
                  child: Text('Create Event'),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateEventPage.pageName);
                  }),
              Divider(),
              Text(
                'Top Events for You!',
                style: Theme.of(context).textTheme.title,
              ),
              StreamBuilder(
                stream: featuredEventsProvider.outFeaturedEvents,
                builder: (ctx, AsyncSnapshot<List<Event>> featuredEvents) {
                  if (featuredEvents.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children:
                            featuredEvents.data.map((Event featuredEvent) {
                          return EventListItem(event: featuredEvent);
                        }).toList(),
                      ),
                    );
                  }
                  return SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userCategoriesSubscription.cancel();
    super.dispose();
  }
}
