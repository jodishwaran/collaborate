import 'dart:async';

import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/page/loading_spinner.dart';
import 'package:collaborate/util/constants.dart';
import 'package:collaborate/util/resources.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:collaborate/widget/signup_button.dart';
import 'package:flutter/material.dart';

enum ButtonType { LOGIN, REGISTER }

class SignUpPage extends StatefulWidget {
  static const String pageName = '/signup';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _firstnameController = TextEditingController();
  var _lastnameController = TextEditingController();
  var _emailController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ButtonType buttonType = ButtonType.REGISTER;
  bool _isLoading = false;

  StreamSubscription _subscription;
  StreamSubscription _userCategoriessubscription;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
     
    });
    super.initState();
  }

  bool _initDone = false;
  @override
  void didChangeDependencies() {
    if (!_initDone) {
      
    }

    _initDone = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return _isLoading
        ? LoadingSpinner()
        : Scaffold(
            key: _scaffoldKey,
            floatingActionButton: SignupButton(
                label: buttonType == ButtonType.REGISTER
                    ? ContentString.register
                    : ContentString.login,
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  var data={'username': _usernameController.text,
                            'password': _passwordController.text,
                            'firstName': _firstnameController.text,
                            'lastName': _lastnameController.text,
                            'emailId': _emailController.text,
                            'locationId': '1'};
                  authBloc.signUp(data);
                }),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _firstnameController,
                      onChanged: (id) {},
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        //hintText: ContentString.firstname,
                        labelText: ContentString.firstname,
                      ),
                    ),
                    TextField(
                      controller: _lastnameController,
                      onChanged: (id) {},
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        //hintText: ContentString.firstname,
                        labelText: ContentString.lastname,
                      ),
                    ),
                    TextField(
                      controller: _usernameController,
                      onChanged: (id) {},
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: ContentString.username_hint,
                        labelText: ContentString.username,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _emailController,
                      onChanged: (id) {},
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: ContentString.email_hint,
                        labelText: ContentString.email,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _emailController,
                      onChanged: (id) {},
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: ContentString.email_hint,
                        labelText: ContentString.email,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      onChanged: (password) {},
                      keyboardType: TextInputType.visiblePassword,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: ContentString.password_hint,
                        labelText: ContentString.password,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _subscription.cancel();
    _userCategoriessubscription.cancel();
    super.dispose();
  }
}
