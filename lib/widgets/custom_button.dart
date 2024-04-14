import 'package:flutter/material.dart';

class GreenOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GreenOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.green), // Green outline border
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: Text(text, style: TextStyle(color: Colors.black),),
    );
  }
}
