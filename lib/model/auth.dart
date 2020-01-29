import 'package:flutter/foundation.dart';

class Auth {
  bool isAuthenticated;
  String userName;

  Auth({this.userName, @required this.isAuthenticated});
}
