import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/category_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/bloc/event_message_bloc.dart';
import 'package:collaborate/page/app_page.dart';
import 'package:collaborate/page/categories_page.dart';
import 'package:collaborate/page/create_event_page.dart';
import 'package:collaborate/page/event_detail_page.dart';
import 'package:collaborate/page/event_messages_page.dart';
import 'package:collaborate/page/explore_page.dart';
import 'package:collaborate/page/loading_spinner.dart';
import 'package:collaborate/page/profile.dart';
import 'package:collaborate/page/sign_up.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

import 'page/login_page.dart';

void main() {
  Stetho.initialize();
  runApp(
    BlocProvider(
      child: BlocProvider(
        child: BlocProvider(
          child: BlocProvider(
            bloc: EventBloc(),
            child: MyApp(),
          ),
          bloc: EventMessageBloc(),
        ),
        bloc: CategoriesBloc(),
      ),
      bloc: AuthBloc(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return StreamBuilder(
      stream: authBloc.outAuthStatus.take(1),
      builder: (ctx, snapshot) {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: Color(0xFF045B9A),
            accentColor: Colors.white60,
            buttonTheme: ButtonThemeData(
                buttonColor: Color(0xFF045B9A),
                textTheme: ButtonTextTheme.primary),
            fontFamily: 'SourceSansPro',
            textTheme: TextTheme(
              headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              title: TextStyle(
                  fontSize: 36.0,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'SourceSansPro'),
              body1: TextStyle(fontSize: 16.0, fontFamily: 'SourceSansPro'),
              body2: TextStyle(fontSize: 18.0, fontFamily: 'SourceSansPro'),
              display1: TextStyle(fontSize: 18.0, fontFamily: 'SourceSansPro'),
            ),
          ),
          home: (snapshot.hasData && snapshot.data.isAuthenticated)
              ? CategoriesPage()
              : FutureBuilder(
                  future: authBloc.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) {
                    if (authResultSnapshot.hasData) {
                      return authResultSnapshot.data ? AppPage() : LogInPage();
                    } else if (authResultSnapshot.hasError) {
                      return LogInPage();
                    } else {
                      return LoadingSpinner();
                    }
                  },
                ),
          routes: {
            Profile.pageName: (ctx) => Profile(),
            EventMessagesPage.pageName: (ctx) => EventMessagesPage(),
            Explore.pageName: (ctx) => Explore(),
            CategoriesPage.pageName: (ctx) => CategoriesPage(),
            CreateEventPage.pageName: (ctx) => CreateEventPage(),
            LogInPage.pageName: (ctx) => LogInPage(),
            SignUpPage.pageName: (ctx) => SignUpPage(),
            AppPage.pageName: (ctx) => AppPage(),
            EventDetailPage.pageName: (ctx) => EventDetailPage()
          },
        );
      },
    );
  }
}
