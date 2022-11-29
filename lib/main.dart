import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pokedex_app/models/hive_poke_model.dart';
import 'package:pokedex_app/provider/favourite_provider.dart';
import 'package:pokedex_app/provider/home_provider.dart';
import 'package:pokedex_app/ui/screens/main_tab_screens/main_tab_screen.dart';
import 'package:pokedex_app/utilities/consts.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeHive();
  await initializeSplashScreen();
  runApp(const MyApp());
}

Future initializeSplashScreen() async {
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
}

Future initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HivePokeModelAdapter());
  await Hive.openBox<HivePokeModel>(Constants.hiveBoxName);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((_) => HomeProvider()),
        ),
        ChangeNotifierProvider(
          create: ((_) => FavouriteProvider()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'NunitoSans'),
        home: const MainTabBarScreen(),
      ),
    );
  }
}
