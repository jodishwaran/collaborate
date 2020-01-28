import 'package:collaborate/widget/dashboard.dart';
import 'package:collaborate/widget/drawer.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  static const String pageName = "/app";

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  var _currentIndex = 0;
  bool _initCalled = false;

  List<Widget> _children = [];

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
    // TODO: implement didChangeDependencies
    if (!_initCalled) {
//      _selectedCategory = ModalRoute.of(context).settings.arguments as String;
    }
    _initCalled = true;

//    final dashboardTab = BlocProvider(bloc: EventBloc(), child: Dashboard());
    _children = [Dashboard()];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Welcome'),
          ),
        ),
        drawer: AppDrawer(),
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
              icon: Icon(Icons.mail),
              title: Text('Messages'),
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile'))
          ],
        ),
      ),
    );
  }
}
