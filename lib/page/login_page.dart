import 'package:collaborate/page/categories_page.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextFormField(
                      style: TextStyle(color: Colors.black54),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black38)),
                      controller: userName,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              child: RaisedButton(
                onPressed: () {
                  print(userName.value.text);
                  Navigator.of(context)
                      .pushReplacementNamed(CategoriesPage.pageName);
                },
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text('Log In'),
              ),
            )
          ]),
    );
  }
}
