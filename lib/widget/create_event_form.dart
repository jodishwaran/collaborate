import 'dart:async';

import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/bloc/location_bloc.dart';
import 'package:collaborate/model/location.dart';
import 'package:collaborate/page/app_page.dart';
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
  var rangePplLimit = RangeValues(2.0, 100);
  bool _loading = false;
  String _selectedLocation;
  var _formData = {
    "eventLocation": "Location1",
    "status": "Created",
    "categoryId": "1",
  };

  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 30);
  DateTime _toDate = DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 30);
  EventBloc eventBloc;
  AuthBloc authBloc;
  LocationBloc locationBloc;

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
      print('********* Form related data');
      _formData['userId'] = authBloc.userId.toString();
      _formData['eventStartTime'] = parseUIDate(_fromDate, _fromTime);
      _formData['eventEndTime'] = parseUIDate(_toDate, _toTime);
      _formData['minPeople'] = rangePplLimit.start.toInt().toString();
      _formData['maxPeople'] = rangePplLimit.end.toInt().toString();
      _formData['locationId'] = _selectedLocation;
      print(_formData);
      final response = await eventBloc.saveNewEvent(_formData, authBloc.token);

      print('form save response ');
      print('$response');

      setState(() {
        _loading = false;
      });

      _showDialog();
//      _showBottomSheet();
    }
  }

  StreamSubscription _locationSubscription;

  List<Location> _locations;

  bool _initDone = false;
  @override
  void didChangeDependencies() {
    if (!_initDone) {
      eventBloc = BlocProvider.of<EventBloc>(context);
      authBloc = BlocProvider.of<AuthBloc>(context);
      locationBloc = BlocProvider.of<LocationBloc>(context);

      locationBloc.fetchLocations(authBloc.token);

      _locationSubscription = locationBloc.outLocations.listen((locations) {
        setState(() {
          _locations = locations;
        });
      });

      //fetchLocations
      _initDone = true;
      super.didChangeDependencies();
    }
  }

//  void _showBottomSheet() {
//    showBottomSheet(
//      context: context,
//      builder: (context) => Container(
//          height: 50,
//          alignment: Alignment.center,
//          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//          decoration: BoxDecoration(
//            color: Colors.grey[300],
//            borderRadius: BorderRadius.circular(10),
//          ),
//          child: Text('Event created succesfully!')),
//    );
//  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Event Created successfully!",
            style: TextStyle(fontSize: 22),
          ),
//          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(AppPage.pageName);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
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
//                    _formData.eventName = value;
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
                      return 'Please enter Event Description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['eventDesc'] = value;
//                    _formData.eventDesc = value;
                    print(_formData);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                InputDecorator(
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: ContentString.event_location),
                  isEmpty: _locations == null,
                  child: DropdownButton<String>(
                    value: _selectedLocation,
                    onChanged: (String newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    },
                    items: _locations == null
                        ? []
                        : _locations
                            .map<DropdownMenuItem<String>>((Location location) {
                            return DropdownMenuItem<String>(
                              value: location.locationId,
                              child: Text(location.locationdesc),
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Text(
                    'Select Minimum and Maximum participant count',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                SliderTheme(
                  data: SliderThemeData(
                    showValueIndicator: ShowValueIndicator.always,
                  ),
                  child: RangeSlider(
                    values: rangePplLimit,
                    min: 2.0,
                    max: 100.0,
                    divisions: 98,
                    onChanged: (RangeValues newValue) {
                      setState(() {
                        rangePplLimit = newValue;
                      });
                    },
                    labels: RangeLabels(
                        '${rangePplLimit.start}', '${rangePplLimit.end}'),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.people_outline),
                            SizedBox(
                              width: 3,
                            ),
                            Text('Min ${rangePplLimit.start}'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.people_outline),
                            SizedBox(
                              width: 3,
                            ),
                            Text('Max ${rangePplLimit.end}'),
                          ],
                        ),
                      ),
                    ],
                  ),
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
