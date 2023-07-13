import 'package:flutter/material.dart';

class QuotexButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final TextStyle textStyle;
  final Color buttonColor;

  const QuotexButton({
    super.key,
    required this.text,
    required this.callback,
    required this.textStyle,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
        color: buttonColor,
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        width: 327,
        height: 44,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
