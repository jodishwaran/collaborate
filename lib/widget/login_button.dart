import 'package:collaborate/widget/reusable_rounded_button.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final String heroTag;
  final Color backgroundColor;
  final Color color;
  const LoginButton({
    this.onPressed,
    this.label,
    this.heroTag,
    this.backgroundColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ReusableRoundedButton(
        child: Text(
          label ?? 'Login',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: color ?? Colors.white,
            fontSize: 15,
          ),
        ),
        // text: 'Login',
        onPressed: onPressed,
        height: 50,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
