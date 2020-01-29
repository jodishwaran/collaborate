import 'package:collaborate/model/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetail extends StatelessWidget {
  final Event event;
  final String imgURL = "";

  EventDetail(this.event);

  Widget _buildLabel(BuildContext context, String labelText) {
    return Expanded(
      flex: 1,
      child: ListTile(
        title: Text(labelText,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildEventDetailItem(
      BuildContext context, String data, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          _buildLabel(context, labelText),
          Expanded(
            child: Text(data),
            flex: 2,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(imgURL),
            radius: 50.0,
          ),
          Card(
            child: Column(
              children: <Widget>[
                _buildEventDetailItem(context, event.eventName, 'Event name'),
                _buildEventDetailItem(
                    context, event.eventDesc, 'Event description'),
                _buildEventDetailItem(
                    context,
                    DateFormat.yMd().add_jms().format(event.eventStartTime),
                    'From'),
                _buildEventDetailItem(
                    context,
                    DateFormat.yMd().add_jms().format(event.eventEndTime),
                    'To'),
                RaisedButton(
                  onPressed: () {},
                  child: Text(
                    'Attend Event',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//_buildLabel(context, 'Event Description'),
//_buildLabel(context, 'From'),
//_buildLabel(context, 'To'),
//_buildLabel(context, 'Organized By'),
