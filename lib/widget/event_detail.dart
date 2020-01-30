import 'package:collaborate/model/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetail extends StatelessWidget {
  final Event event;
  final String imgURL =
      'https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60%20100w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=60%20200w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=60%20300w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60%20400w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60%20500w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60%20600w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60%20700w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60%20800w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60%20900w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60%201000w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=60%201100w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1200&q=60%201200w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60%201296w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60%201400w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=60%201600w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1800&q=60%201800w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2000&q=60%202000w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2048&q=60%202048w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2048&q=60%202048w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2048&q=60%202048w';

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
    print('image url $imgURL');
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
