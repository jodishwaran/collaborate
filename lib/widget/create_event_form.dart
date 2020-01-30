import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/util/constants.dart';
import 'package:collaborate/util/resources.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:flutter/material.dart';

import 'date_time_picker.dart';

class CreateEventForm extends StatefulWidget {
  @override
  _CreateEventFormState createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  var _form = GlobalKey<FormState>();
  bool _loading = false;
  var _formData = {
    "eventName": "TestEvent gk 2",
    "eventLocation": "Location1",
    "eventStartTime": "2020-01-31T00:00:00.000",
    "eventEndTime": "2020-01-31T01:00:00.000",
    "eventDesc": "Event created for test",
    "status": "Created",
    "minPeople": "0",
    "maxPeople": "20",
    "userId": "1",
    "categoryId": "1",
    "locationId": "1"
  };

  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime _toDate = DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 28);
  final List<String> _allLocations = <String>[
    'Location1',
    'Marathalli',
    'Whitefield',
    'Majestic'
  ];
  String _location = 'Ecoworld';

  EventBloc eventBloc;
  AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
  }

  void _onCreateEvent(context) async {
    print('form clicked');
    if (_form.currentState.validate()) {
      _form.currentState.save();
      setState(() {
        _loading = true;
      });

      _formData['userId'] = authBloc.userId.toString();
      final response = await eventBloc.saveNewEvent(_formData, authBloc.token);

      print('form save response ');
      print('$response');

      setState(() {
        _loading = false;
      });

      _showDialog();
    }
  }

  bool _initDone = false;
  @override
  void didChangeDependencies() {
    if (!_initDone) {
      eventBloc = BlocProvider.of<EventBloc>(context);
      authBloc = BlocProvider.of<AuthBloc>(context);
      _initDone = true;
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Event Created successfully!"),
//          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: _loading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : Column(
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
                    _formData['eventName'] = value;
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
                    _formData['eventDesc'] = value;
                    print(_formData);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                InputDecorator(
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: ContentString.event_location),
                  isEmpty: _formData["eventLocation"] == null,
                  child: DropdownButton<String>(
                    value: _formData["eventLocation"],
                    onChanged: (String newValue) {
                      setState(() {
                        _formData["eventLocation"] = newValue;
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
                  onPressed: () => _onCreateEvent(context),
                )
              ],
            ),
    );
  }
}
