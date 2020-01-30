import 'package:collaborate/model/event.dart';
import 'package:collaborate/page/event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventListItem extends StatelessWidget {
  final Event event;
  EventListItem({@required this.event});

  final String imageUrl =
      'https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60%20100w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=60%20200w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=60%20300w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60%20400w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60%20500w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60%20600w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60%20700w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60%20800w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60%20900w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60%201000w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=60%201100w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1200&q=60%201200w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60%201296w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60%201400w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=60%201600w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1800&q=60%201800w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2000&q=60%202000w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2048&q=60%202048w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2048&q=60%202048w,%20https://images.unsplash.com/photo-1498629718354-908b63db7fb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2048&q=60%202048w';

  get isUpComingUserEvent {
    return event.userRequestedStatus != null;
  }

  get upComingEventStatus {
    if (!isUpComingUserEvent) {
      return '';
    }

    return event.userRequestedStatus;
  }

  get upComingEventTextColor {
    if (!isUpComingUserEvent) {
      return null;
    }

    if (upComingEventStatus == "ACCEPTED") {
      return Colors.green;
    } else if (upComingEventStatus == "REQUESTED") {
      return Colors.amberAccent;
    } else {
      return Colors.redAccent;
    }

    return upComingEventStatus == "";
  }

  Widget _buildDateDisplay(
      BuildContext context, DateTime date, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            size: 30.0,
          ),
          Text(labelText),
          Text(
            DateFormat.yMd().add_jms().format(date).toString(),
            style: Theme.of(context).textTheme.body1,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                width: double.infinity,
                child: Text(
                  '${event.eventName}',
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white, fontSize: 22.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        '${event.eventDesc}',
                        style: Theme.of(context).textTheme.display1,
                      ),
                    )
                  ],
                ),
              ),
              _buildDateDisplay(context, event.eventStartTime, 'From'),
              _buildDateDisplay(context, event.eventEndTime, 'to'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'view more',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(EventDetailPage.pageName,
                          arguments: event);
                    },
                  )
                ],
              )
            ],
          ),
        ),
        isUpComingUserEvent
            ? Positioned(
                top: 75,
                right: 20,
                child: Text(
                  upComingEventStatus,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: upComingEventTextColor),
                ))
            : Container(),
      ],
    );
  }
}
