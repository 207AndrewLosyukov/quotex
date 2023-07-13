import 'package:flutter/material.dart';
import 'package:quotex/quotex_colors.dart';

class ScannerButton extends StatefulWidget {
  final VoidCallback callback;
  final String text;
  bool isActive;
  Color activeButtonColor;

  ScannerButton({
    super.key,
    required this.text,
    required this.callback,
    required this.isActive,
    required this.activeButtonColor
  });

  @override
  State<ScannerButton> createState() => _ScannerButtonState();
}

class _ScannerButtonState extends State<ScannerButton> {
  final Color _inactiveButtonColor =
      const Color(QuotexColors.quotexBackgroundCode);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: widget.isActive
                ? widget.activeButtonColor
                : const Color(
                    QuotexColors.quotexGreyTextCode,
                  ),
          ),
          color: widget.isActive ? widget.activeButtonColor : _inactiveButtonColor,
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        width: 106,
        height: 47,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Onest",
              fontWeight: FontWeight.w700,
              color: Color(QuotexColors.quotexWhiteCode),
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
