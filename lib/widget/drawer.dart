import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/page/categories_page.dart';
import 'package:collaborate/page/login_page.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  _buildDrawerTile(String title, IconData icon, Function onTap) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        icon,
        color: Colors.indigo,
        size: 24.0,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Drawer(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: _buildDrawerTile('Choose Categories', Icons.category, () {
              Navigator.of(context)
                  .pushReplacementNamed(CategoriesPage.pageName);
            }),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: _buildDrawerTile('Sign out', Icons.all_out, () async {
              await authBloc.logout();
              Navigator.of(context).pushReplacementNamed(LogInPage.pageName);
            }),
          ),
        ],
      ),
    ));
  }
}
