import 'package:collaborate/bloc/category_bloc.dart';
import 'package:collaborate/page/app_page.dart';
import 'package:collaborate/page/categories_page.dart';
import 'package:collaborate/page/create_event_page.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:flutter/material.dart';

import 'page/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF045B9A),
        accentColor: Colors.white60,
        buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF045B9A), textTheme: ButtonTextTheme.primary),
        fontFamily: 'Pacifico',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
              fontFamily: 'SourceSansPro'),
          body1: TextStyle(fontSize: 16.0, fontFamily: 'SourceSansPro'),
          body2: TextStyle(fontSize: 18.0, fontFamily: 'SourceSansPro'),
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (ctx) => LogInScreen(),
        CategoriesPage.pageName: (ctx) => BlocProvider(
              bloc: CategoriesBloc(),
              child: CategoriesPage(),
            ),
        CreateEventPage.pageName: (ctx) => CreateEventPage(),
        AppPage.pageName: (ctx) => AppPage()
      },
    );
  }
}
