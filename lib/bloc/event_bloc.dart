import 'package:collaborate/model/category.dart';
import 'package:collaborate/model/event.dart';
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

  Future<void> getFeaturedEvents(List<Category> selectedCategories) async {
    await Future.delayed(Duration(seconds: 0));

    final List<Event> featuredEvents = [
      Event(
        id: 1.toString(),
        title: 'IPL match 1',
        createdBy: "GK",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
        endDate: DateTime.now(),
        startDate: DateTime.now(),
        status: EventStatus.Scheduled,
      ),
      Event(
        id: 2.toString(),
        title: 'IPL match 2',
        createdBy: "IN",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
        endDate: DateTime.now(),
        startDate: DateTime.now(),
        status: EventStatus.Scheduled,
      ),
      Event(
        id: 3.toString(),
        title: 'IPL match 3',
        createdBy: "IN",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
        endDate: DateTime.now(),
        startDate: DateTime.now(),
        status: EventStatus.Scheduled,
      ),
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
