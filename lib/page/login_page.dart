import 'dart:async';

import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/category_bloc.dart';
import 'package:collaborate/model/auth.dart';
import 'package:collaborate/model/category.dart';
import 'package:collaborate/page/app_page.dart';
import 'package:collaborate/page/categories_page.dart';
import 'package:collaborate/page/loading_spinner.dart';
import 'package:collaborate/page/sign_up.dart';
import 'package:collaborate/util/constants.dart';
import 'package:collaborate/util/resources.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:collaborate/widget/login_button.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum ButtonType { LOGIN, REGISTER }

class LogInPage extends StatefulWidget {
  static const String pageName = '/log-in';
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ButtonType buttonType = ButtonType.LOGIN;
  bool _isLoading = false;

  StreamSubscription _subscription;
  StreamSubscription _userCategoriessubscription;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _emailController.text = "ankit.sood";
      _passwordController.text = "Welcome1";
    });
    super.initState();
  }

  bool _initDone = false;
  @override
  void didChangeDependencies() {
    if (!_initDone) {
      final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
      final CategoriesBloc categoriesBloc =
          BlocProvider.of<CategoriesBloc>(context);

      _subscription = authBloc.outAuthStatus.listen((auth) async {
        if (auth.isAuthenticated == true) {
          categoriesBloc.fetchUserCategories(authBloc.userId, authBloc.token);
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });

      _userCategoriessubscription = CombineLatestStream.list<dynamic>(
              [categoriesBloc.outUserCategories, authBloc.outAuthStatus])
          .listen((data) {
        List<Category> userCategories = data[0];
        Auth auth = data[1];

        if (auth.isAuthenticated) {
          if (userCategories.isNotEmpty) {
            print('User Has categories, going to app page ');
            Navigator.of(context).pushReplacementNamed(AppPage.pageName);
            return;
          }
          print('User Has No categories, going to categories page ');

          Navigator.of(context).pushReplacementNamed(CategoriesPage.pageName);
        }
      });
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
            
            floatingActionButton: LoginButton(
                label: buttonType == ButtonType.LOGIN
                    ? ContentString.login
                    : ContentString.register,
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  authBloc.logIn(
                      _emailController.text, _passwordController.text);
                }),
                
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                      keyboardType: TextInputType.emailAddress,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: ContentString.password_hint,
                        labelText: ContentString.password,
                      ),
                    ),
                    FlatButton(
                    child: Text(
                      ContentString.register,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignUpPage.pageName);
                    },
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
