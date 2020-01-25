import 'package:collaborate/widget/date_time_picker.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  static const String pageName = 'create_event';
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  var _form = GlobalKey<FormState>();
  var _formData = {
    'name': '',
    'description': '',
  };

  void _onCreateEvent() {
    print('form clicked');
    if (_form.currentState.validate()) {
      _form.currentState.save();
      print('form saved');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Create Event'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(),
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 40.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
//              height: 350,
              child: Card(
                color: Colors.white,
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        margin: EdgeInsets.only(bottom: 3.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black38),
                          decoration: InputDecoration(
                            labelText: 'Event Name',
                            labelStyle: TextStyle(color: Colors.black),
//                      filled: true,
//                      fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Event name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _formData['name'] = value;
                            print(_formData);
                          },
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black38),
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: 'Event description',
                          hintStyle: TextStyle(color: Colors.black),
//                    filled: true,
//                    fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Event name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formData['description'] = value;
                          print(_formData);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      DateAndTimePickerDemo(),
                      RaisedButton(
                        child: Text('Create Event'),
                        onPressed: _onCreateEvent,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
