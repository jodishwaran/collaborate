import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/page/explore_page.dart';
import 'package:collaborate/page/profile.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:collaborate/widget/dashboard.dart';
import 'package:collaborate/widget/drawer.dart';
import 'package:flutter/material.dart';

import 'create_event_page.dart';

class AppPage extends StatefulWidget {
  static const String pageName = "/app";

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  var _currentIndex = 0;
  bool _initDone = false;

  List<Widget> _children = [];

  EventBloc eventBloc;
  AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    if (!_initDone) {
      eventBloc = BlocProvider.of<EventBloc>(context);
      authBloc = BlocProvider.of<AuthBloc>(context);
    }
    _initDone = true;
    _children = [Dashboard(), Explore(), Profile()];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Ketch up'),
          ),
          actions: <Widget>[],
        ),
        drawer: AppDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).pushNamed(CreateEventPage.pageName);
            eventBloc.fetchUserEvents(authBloc.userId, authBloc.token);
          },
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              title: Text('Explore'),
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile'))
          ],
        ),
      ),
    );
  }
}
