import 'package:collaborate/util/constants.dart';
import 'package:collaborate/util/resources.dart';
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

  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime _toDate = DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 28);
  final List<String> _allLocations = <String>[
    'Ecoworld',
    'Marathalli',
    'Whitefield',
    'Majestic'
  ];
  String _location = 'Ecoworld';

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
                      TextFormField(
                        style: TextStyle(color: Colors.black38),
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: ContentString.event_name,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Event name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formData['name'] = value;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black38),
                        maxLines: 2,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: ContentString.event_description,
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
                      InputDecorator(
                        decoration: kTextFieldDecoration.copyWith(
                            labelText: ContentString.event_location),
                        isEmpty: _location == null,
                        child: DropdownButton<String>(
                          value: _location,
                          onChanged: (String newValue) {
                            setState(() {
                              _location = newValue;
                            });
                          },
                          items: _allLocations
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      DateTimePicker(
                        labelText: ContentString.event_start,
                        selectedDate: _fromDate,
                        selectedTime: _fromTime,
                        selectDate: (DateTime date) {
                          setState(() {
                            _fromDate = date;
                          });
                        },
                        selectTime: (TimeOfDay time) {
                          setState(() {
                            _fromTime = time;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      DateTimePicker(
                        labelText: ContentString.event_end,
                        selectedDate: _toDate,
                        selectedTime: _toTime,
                        selectDate: (DateTime date) {
                          setState(() {
                            _toDate = date;
                          });
                        },
                        selectTime: (TimeOfDay time) {
                          setState(() {
                            _toTime = time;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        child: Text(ContentString.event_create),
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
