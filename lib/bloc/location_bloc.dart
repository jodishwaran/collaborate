import 'package:collaborate/api/http_helper.dart';
import 'package:collaborate/model/location.dart';
import 'package:collaborate/util/endpoints.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:rxdart/subjects.dart';

class LocationBloc extends BlocBase {
  final BehaviorSubject<List<Location>> _subject =
      BehaviorSubject<List<Location>>();

  Sink<List<Location>> get _inLocations => _subject.sink;

  Stream<List<Location>> get outLocations => _subject.stream;

  fetchLocations(String token) async {
    final url = Endpoints.kGetLocations;
    final locationsResp = await HTTPHelper().get(token: token, url: url);

    List<Location> locations = List<Location>.from(locationsResp.map((json) {
      return Location.fromJson(json);
    }));

    _inLocations.add(locations);
  }

  @override
  void dispose() {
    _subject.close();
    super.dispose();
  }
}
