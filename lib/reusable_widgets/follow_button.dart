import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final String text;

  const FollowButton({super.key,
  required this.backgroundColor,
  required this.borderColor,
  required this.function,
  required this.text,
  required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(text,style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold
          ),),
          width: 200,
          height: 27,
        ),
      ),
    );
  }
}