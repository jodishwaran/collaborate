import 'dart:async';
import 'dart:convert';

import 'package:collaborate/api/http_helper.dart';
import 'package:collaborate/model/auth.dart';
import 'package:collaborate/util/constants.dart';
import 'package:collaborate/util/endpoints.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends BlocBase {
  static const String klogInURL =
      "https://ms-meetup-1.azurewebsites.net/ketchup/authenticate";

  Sink<Auth> get _inAuthStatus => _authSubject.sink;

  final BehaviorSubject<Auth> _authSubject = BehaviorSubject<Auth>();

  Stream<Auth> get outAuthStatus => _authSubject.stream;

  String _token;
  DateTime _expiresOn;
  String _userName;
  int _userId;
  Timer _authTimer;

//  bool get isAuth {
//    return _token != null;
//  }

  bool get isAuth {
    if (_token == null) {
      return false;
    }
    return _expiresOn.isAfter(DateTime.now());
  }

  String get token {
    if (isAuth) {
      return _token;
    }

    return null;
  }

  int get userId {
    return _userId;
  }

  String get userName {
    return _userName;
  }

  logIn(String username, String password) async {
    try {
      final responseBody = await _authenticate(username, password);
      if (responseBody["token"] != null) {
        _token = responseBody["token"];
        _expiresOn = parseDateString(responseBody["expiresOn"]);
        _userName = responseBody["userName"];
        _userId = responseBody["userId"];

//        print(_token);
//        print(_expiresOn.toLocal());
//        print(_expiresOn.toUtc());
//        print(_userName);

        final prefs = await SharedPreferences.getInstance();

        final userData = json.encode(
          {
            'token': _token,
            'userId': _userId,
            'userName': _userName,
            'expiresOn': _expiresOn.toIso8601String(),
          },
        );

        prefs.setString('userData', userData);
        _inAuthStatus.add(Auth(isAuthenticated: true, userName: _userName));
      } else {
        _inAuthStatus.add(Auth(isAuthenticated: false));
        print('Token not available during login ');
      }
    } catch (error) {
      _inAuthStatus.add(Auth(isAuthenticated: false));
      print('Error logging in user - $error');
      throw error;
    }
  }

  signUp() {}

  Future<dynamic> _authenticate(
    String user,
    String pwd,
  ) async {
    final data = {'username': user, 'password': pwd};
    final responseBody = await HTTPHelper().post(
        url: Endpoints.klogin,
        data: data,
        headers: {"Content-Type": "application/json"});

    return responseBody;
  }

  Future<bool> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey('userData')) {
        print('no user data found :(');
        return false;
      }

      final userData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;

      _token = userData["token"];
      _expiresOn = parseDateString(userData["expiresOn"]);
      _userId = userData["userId"];
      _userName = userData["userName"];

      if (_expiresOn.isBefore(DateTime.now())) {
        print('token expired :(');
        return false;
      }

//      _inAuthStatus.add(Auth(isAuthenticated: true, userName: _userName));
      print('user has token in memore sucess log in :)');

      startAutoLogOutTimer();

      return true;
    } catch (error, stacktrace) {
      print('Erro occured $error, stack - $stacktrace');
    }
  }

  Future<void> logout() async {
    _token = null;
    _userName = null;
    _expiresOn = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    _inAuthStatus.add(Auth(isAuthenticated: false));
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  startAutoLogOutTimer() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final expiresInSec = _expiresOn.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: expiresInSec), logout);
  }
}
