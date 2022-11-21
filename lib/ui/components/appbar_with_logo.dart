import 'package:flutter/material.dart';
import 'package:pokedex_app/ui/components/logo_and_text.dart';

class AppBarWithLogo extends StatelessWidget with PreferredSizeWidget {
  const AppBarWithLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const LogoAndText(),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
