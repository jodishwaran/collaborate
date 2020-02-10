import 'package:flutter/material.dart';
import 'package:collaborate/model/event_message.dart';

class MessageItem extends StatelessWidget {
  final EventMessage message;
  MessageItem(this.message);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        color: Color(0xFFDDDDDD),
        padding: EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.userName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.start,
            ),
            Text(
              message.postedAt,
              // "2020-01-20 12:20",
              style: TextStyle(fontSize: 10),
              textAlign: TextAlign.left,
            ),
            // Text(message.message)
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
              // child: Text("What does Hoki mean..?"),
              child: Text(message.message),
            )
          ],
        ),
      ),
    );
  }
}
