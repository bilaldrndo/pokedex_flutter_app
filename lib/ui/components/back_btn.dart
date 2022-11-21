import 'package:flutter/material.dart';
import 'package:pokedex_app/utilities/consts.dart';

class CustomBackBtn extends StatelessWidget {
  const CustomBackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Image.asset(
        Constants.assetBackBtnPath,
        width: 8,
      ),
    );
  }
}
