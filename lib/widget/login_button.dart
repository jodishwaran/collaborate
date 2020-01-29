import 'package:collaborate/widget/reusable_rounded_button.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final String heroTag;
  const LoginButton({this.onPressed, this.label, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Hero(
        tag: heroTag ?? 'login',
        transitionOnUserGestures: true,
        child: ReusableRoundedButton(
          child: Text(
            label ?? 'Login',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          // text: 'Login',
          onPressed: onPressed,
          height: 50,
          backgroundColor: Colors.indigo,
        ),
      ),
    );
  }
}
