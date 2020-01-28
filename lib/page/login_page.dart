import 'package:collaborate/page/app_page.dart';
import 'package:collaborate/util/constants.dart';
import 'package:collaborate/util/resources.dart';
import 'package:collaborate/widget/login_button.dart';
import 'package:flutter/material.dart';

enum ButtonType { LOGIN, REGISTER }

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var userName = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ButtonType buttonType = ButtonType.LOGIN;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
//      appBar: TopBar(
//        title: ContentString.login,
//        child: kBackBtn,
//        onPressed: () {
//          Navigator.pop(context);
//        },
//      ),
      floatingActionButton: LoginButton(
          label: buttonType == ButtonType.LOGIN
              ? ContentString.login
              : ContentString.register,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(AppPage.pageName);
          }),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (id) {},
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                decoration: kTextFieldDecoration.copyWith(
                  hintText: ContentString.email_hint,
                  labelText: ContentString.email,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                obscureText: true,
                onChanged: (password) {},
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
}

//
//Card(
//margin: EdgeInsets.symmetric(horizontal: 10.0),
//child: Column(
//children: <Widget>[
//Container(
//child: TextFormField(
//style: TextStyle(color: Colors.black54),
//decoration: InputDecoration(
//fillColor: Colors.white,
//filled: true,
//labelText: 'Email',
//labelStyle: TextStyle(color: Colors.black38)),
//controller: userName,
//keyboardType: TextInputType.emailAddress,
//),
//),
//],
//),
//),
//SizedBox(
//height: 30.0,
//),
//Container(
//child: RaisedButton(
//onPressed: () {
//print(userName.value.text);
//Navigator.of(context)
//    .pushReplacementNamed(CategoriesPage.pageName);
//},
//padding: EdgeInsets.symmetric(horizontal: 30.0),
//child: Text('Log In'),
//),
//)
