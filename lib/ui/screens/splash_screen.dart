import 'package:flutter/material.dart';
import 'package:pokedex_app/utilities/consts.dart';
import 'package:pokedex_app/utilities/theme.dart';

// This SplashScreen class is just here to make sure that if this was the Splash Screen
// varient You wanted instead of the native one that has been added
// This can be added in main.dart in the home field instead of HomeScreen()

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomTheme.darkBluePrimaryColor,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SizedBox(
            height: 90,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Constants.assetsLogoPath,
                  width: 75,
                  height: 75,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 19),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'POKEMON',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 3,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Pokedex',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
