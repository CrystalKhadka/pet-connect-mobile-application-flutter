import 'package:final_assignment/features/splash/presentation/view/splash_screen.dart';
import 'package:flutter/material.dart';

import 'navigator_key/navigator_key.dart';
import 'themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Pet Adoption App',
      theme: AppTheme.getApplicationTheme(false),
      home: const SplashView(),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ne', 'NP'),
      ],
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
      ],
    );
  }
}
