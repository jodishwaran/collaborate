import 'package:collaborate/model/event_message.dart';
import 'package:collaborate/util/endpoints.dart';

import 'package:collaborate/widget/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../api/http_helper.dart';

class EventMessageBloc extends BlocBase {
  static const String kGET_Event_Message_URL =
      "https://ms-meetup-1.azurewebsites.net/messages";

  EventMessageBloc();

  final BehaviorSubject<List<EventMessage>> _eventMessageSubject =
      BehaviorSubject<List<EventMessage>>();
  Sink<List<EventMessage>> get _inMessages => _eventMessageSubject.sink;
  Stream<List<EventMessage>> get outMessages => _eventMessageSubject.stream;

  Future<void> fetchEventMessages(int eventId, String token) async {
    final headers = {'Authorization': 'Bearer $token'};
    final responseBody = await HTTPHelper()
        .get(url: Endpoints.kgetEventMessages(eventId), headers: headers);
    List<EventMessage> messages =
        List<EventMessage>.from(responseBody.map((messageObject) {
      return EventMessage.fromJsonObject(messageObject);
    }));
    _inMessages.add(messages);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _eventMessageSubject.close();
    super.dispose();
  }
}
