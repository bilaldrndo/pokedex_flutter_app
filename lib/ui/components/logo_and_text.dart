import 'package:flutter/material.dart';
import 'package:pokedex_app/ui/components/global_text_widget.dart';
import 'package:pokedex_app/utilities/consts.dart';
import 'package:pokedex_app/utilities/theme.dart';

class LogoAndText extends StatelessWidget {
  const LogoAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          Constants.assetsLogoPath,
          width: 24,
        ),
        const SizedBox(width: 8),
        GlobalTextWidget(
          'Pokedex',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: CustomTheme.darkBlueTitleColor,
        )
      ],
    );
  }
}
