import 'package:collaborate/model/Category.dart';
import 'package:collaborate/model/event.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class EventBloc extends BlocBase {
  final BehaviorSubject<List<Event>> _subject = BehaviorSubject<List<Event>>();
  Sink<List<Event>> get _inEvents => _subject.sink;
  Stream<List<Event>> get outEvents => _subject.stream;

  getFeaturedEvents(List<Category> selectedCategories) {
    final List<Event> featuredEvents = [
      Event(
        id: 1.toString(),
        title: 'IPL match 1',
        createdBy: "GK",
        description: "desc",
        endDate: DateTime.now(),
        startDate: DateTime.now(),
        status: EventStatus.Scheduled,
      ),
      Event(
        id: 2.toString(),
        title: 'IPL match 2',
        createdBy: "IN",
        description: "desc",
        endDate: DateTime.now(),
        startDate: DateTime.now(),
        status: EventStatus.Scheduled,
      ),
    ];

    _inEvents.add(featuredEvents);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _subject.close();
    super.dispose();
  }
}
