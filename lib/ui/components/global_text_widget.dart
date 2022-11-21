import 'package:flutter/material.dart';

class GlobalTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final int fontSize;
  final TextAlign textAlign;

  const GlobalTextWidget(
    this.text, {
    super.key,
    required this.color,
    required this.fontWeight,
    required this.fontSize,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize.toDouble(),
      ),
    );
  }
}
