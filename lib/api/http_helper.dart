import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class HTTPHelper {
  get(String url) async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else {}
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 'HTTP Error occured during get operation';
    }
  }

  post(String url) {}

  put(String url) {}

  delete(String url) {}
}
