import 'package:flutter/material.dart';
import 'package:pokedex_app/ui/components/global_text_widget.dart';
import 'package:pokedex_app/utilities/theme.dart';

class BasicInfoCell extends StatelessWidget {
  final String title;
  final Object value;
  const BasicInfoCell({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalTextWidget(
          title,
          color: CustomTheme.darkGrayTitleColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 3),
        GlobalTextWidget(
          value.toString(),
          color: CustomTheme.darkBlueTitleColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
