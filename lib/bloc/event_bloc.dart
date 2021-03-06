import 'package:collaborate/api/http_helper.dart';
import 'package:collaborate/model/category.dart';
import 'package:collaborate/model/event.dart';
import 'package:collaborate/model/event_request.dart';
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

  final BehaviorSubject<List<Event>> __allEventsSubject =
      BehaviorSubject<List<Event>>();
  Sink<List<Event>> get _inAllEvents => __allEventsSubject.sink;
  Stream<List<Event>> get outAllEvents => __allEventsSubject.stream;

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

  final BehaviorSubject<bool> _createdEventssubject = BehaviorSubject<bool>();
  Sink<bool> get _inCreatedEvents => _createdEventssubject.sink;
  Stream<bool> get outCreatedEvents => _createdEventssubject.stream;

  final BehaviorSubject<List<EventRequest>> _requestForEventsubject =
      BehaviorSubject<List<EventRequest>>();
  Sink<List<EventRequest>> get _inRequestedEvents =>
      _requestForEventsubject.sink;
  Stream<List<EventRequest>> get outRequestedEvents =>
      _requestForEventsubject.stream;

  Future<void> fetchUserEvents(int userId, String token) async {
    final url = Endpoints.kgetUserEvents(userId);

    final responseBody = await HTTPHelper().get(url: url, token: token);

    print(responseBody.forEach((event) {
      print(event);
    }));

    final List<Event> userEvents = _mapResponseToEvents(responseBody);
    _inOrganizedEvents.add(userEvents);
  }

  Future<void> fetchAllEvents(String token) async {
    final url = Endpoints.kgetAllEvents;

    final responseBody = await HTTPHelper().get(url: url, token: token);

    print(responseBody.forEach((event) {
      print(event);
    }));

    final List<Event> allEvents = _mapResponseToEvents(responseBody);
    _inAllEvents.add(allEvents);
  }

  Future<void> fetchUserUpcomingEvents(int userId, String token) async {
    final url = Endpoints.kgetAllUserUpcomingEvents(userId);

    final responseBody = await HTTPHelper().get(url: url, token: token);

    print(responseBody.forEach((event) {
      print(event);
    }));

    final List<Event> userUpcomingEvents =
        List<Event>.from(responseBody.map((json) {
      return Event.fromServerlessJson(json);
    }));
    _inSubscribedEvents.add(userUpcomingEvents);
  }

  _mapResponseToEvents(response) {
    return List<Event>.from(response.map((json) {
      return Event.fromJson(json);
    }));
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

  Future<dynamic> saveNewEvent(eventData, String token) async {
    return await HTTPHelper()
        .post(url: Endpoints.kcreateEvent, data: eventData, token: token);
  }

  Future<dynamic> approveOrRejectEvent(payload, String token) async {
    return await HTTPHelper()
        .put(url: Endpoints.kApproveEvent, data: payload, token: token);
  }

  Future<dynamic> attendEvent(payload, String token) async {
    return await HTTPHelper()
        .post(url: Endpoints.kAttendEvent, data: payload, token: token);
  }

  Future<void> fetchRequestsByEvent(int eventId, String token) async {
    final url = '${Endpoints.host}events/requests/$eventId';

    final responseBody = await HTTPHelper().get(url: url, token: token);
    print('evnt bloc -event requests fired responde  - $responseBody');
    print(responseBody.forEach((event) {
      print(event);
    }));

    final List<EventRequest> requestedEvents =
        List<EventRequest>.from(responseBody.map((json) {
      return EventRequest.fromJson(json);
    }));
    _inRequestedEvents.add(requestedEvents);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    __featuredEventsSubject.close();
    _organizedEventsSubject.close();
    _subscribedEventssubject.close();
    __allEventsSubject.close();
    _createdEventssubject.close();
    _requestForEventsubject.close();
    super.dispose();
  }
}
