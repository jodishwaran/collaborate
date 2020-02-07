import 'package:collaborate/bloc/location_bloc.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:collaborate/widget/create_event_form.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  static const String pageName = 'create_event';
//  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

//
class _CreateEventPageState extends State<CreateEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(
          child: Text('Create Event'),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, viewportConstrainsts){
         return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstrainsts.maxHeight
              ),
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
                      elevation: 0,
                      child: BlocProvider(
                        child: CreateEventForm(),
                        bloc: LocationBloc(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
//        child: ,
      ),
    );
  }
}
