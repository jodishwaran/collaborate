import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  static final pageName = '/profile';
  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Container(
      child: Center(
        child: Text('${authBloc.userName}'),
      ),
    );
  }
}
