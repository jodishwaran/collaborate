import 'package:collaborate/widget/reusable_rounded_button.dart';
import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final String heroTag;
  const SignupButton({this.onPressed, this.label, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Hero(
        tag: heroTag ?? 'Signup',
        transitionOnUserGestures: true,
        child: ReusableRoundedButton(
          child: Text(
            label ?? 'Signup',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          onPressed: onPressed,
          height: 50,
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
