import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class HTTPHelper {
  get({String url, Map<String, String> headers, String token}) async {
    print(token);

    if (headers != null) {
      print('headers available for url : $url');
    }

    if (headers == null) {
      headers = {'Authorization': 'Bearer $token'};
    } else {
      if (!headers.containsKey('Authorization')) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    try {
      final response = await http.get(url, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        print("HTTP Error occured: not authorrized 401");

        return {'error': "User Not Authorized"};
      } else {
        print("HTTP Error occured: Status code is not 200/401");
        return {'error': "HTTP Error occured: Status code is not 200/401"};
      }
    } on FormatException catch (e) {
      print('The provided string is not valid JSON');
      return "Success";
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 'HTTP Error occured during get operation';
    }
  }

  Future<dynamic> post(
      {String url,
      dynamic data,
      Map<String, String> headers,
      String token}) async {
    try {
      if (headers == null) {
        headers = {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        };
      }

//      print(token);

//      print('posting data url $url');
//      print(convert.jsonEncode(data));
      final response = await http.post(url,
          body: convert.jsonEncode(data), headers: headers);

      print(response.body);
      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        return {'error': "User Not Authorized"};
      } else {
        print("HTTP Error occured: Status code is not 200/401");
        return {'error': "HTTP Error occured: Status code is not 200/401"};
      }
    } on FormatException catch (e) {
      print('The provided string is not valid JSON');
      return "Success";
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 'HTTP Error occured during get operation';
    }
  }

  put(String url) {}

  delete(String url) {}
}
