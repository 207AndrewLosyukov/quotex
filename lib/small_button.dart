import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final TextStyle textStyle;
  final Color color;

  const SmallButton({
    super.key,
    required this.text,
    required this.callback,
    required this.textStyle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Container(
          color: color,
          width: 156,
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
      ),
    );
  }
}
