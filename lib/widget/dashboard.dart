import 'package:collaborate/page/create_event_page.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Dashboard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                  })
            ],
          ),
        ),
      ],
    );
  }
}
