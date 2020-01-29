import 'package:collaborate/api/http_helper.dart';
import 'package:collaborate/model/category.dart';
import 'package:collaborate/model/event.dart';
import 'package:collaborate/util/constants.dart';
import 'package:collaborate/util/endpoints.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class EventBloc extends BlocBase {
  //Featured Events
  final BehaviorSubject<List<Event>> __featuredEventsSubject =
      BehaviorSubject<List<Event>>();
  Sink<List<Event>> get _inFeaturedEvents => __featuredEventsSubject.sink;
  Stream<List<Event>> get outFeaturedEvents => __featuredEventsSubject.stream;

  //User Organized events
  final BehaviorSubject<List<Event>> _organizedEventsSubject =
      BehaviorSubject<List<Event>>();
  Sink<List<Event>> get _inOrganizedEvents => _organizedEventsSubject.sink;
  Stream<List<Event>> get outOrganizedEvents => _organizedEventsSubject.stream;

  //User Subscribed events
  final BehaviorSubject<List<Event>> _subscribedEventssubject =
      BehaviorSubject<List<Event>>();
  Sink<List<Event>> get _inSubscribedEvents => _subscribedEventssubject.sink;
  Stream<List<Event>> get outSubscribedEvents =>
      _subscribedEventssubject.stream;

  fetchUserEvents(int userId, String token) async {
    final url = Endpoints.kgetUserEvents(userId);

    await HTTPHelper().get(url: url, token: token);
  }

  Future<void> getFeaturedEvents(List<Category> selectedCategories) async {
    await Future.delayed(Duration(seconds: 0));

    final List<Event> featuredEvents = [
      Event(
        eventId: 1,
        eventName: "TestEvent",
        eventLocation: "Location1",
        eventStartTime: parseDateString("2020-01-30T00:00:00.000+0000"),
        eventEndTime: parseDateString("2020-01-30T01:00:00.000+0000"),
        eventDesc: "Event created for test",
        status: "Created",
        minPeople: 0,
        maxPeople: 20,
        userId: 1,
        categoryId: 1,
        locationId: 1,
      ),
      Event(
        eventId: 2,
        eventName: "TestEvent 2",
        eventLocation: "Location2",
        eventStartTime: parseDateString("2020-01-30T00:00:00.000+0000"),
        eventEndTime: parseDateString("2020-01-30T01:00:00.000+0000"),
        eventDesc: "Event created for test 2",
        status: "Created",
        minPeople: 0,
        maxPeople: 20,
        userId: 1,
        categoryId: 1,
        locationId: 1,
      )
    ];

    _inFeaturedEvents.add(featuredEvents);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    __featuredEventsSubject.close();
    _organizedEventsSubject.close();
    _subscribedEventssubject.close();
    super.dispose();
  }
}
