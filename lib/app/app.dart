import 'package:final_assignment/app/themes/app_theme.dart';
import 'package:final_assignment/core/common/provider/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/splash/presentation/view/splash_screen.dart';
import 'navigator_key/navigator_key.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkTheme = ref.watch(darkThemeProvider);
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Pet Adoption App',
      theme: AppTheme.getApplicationTheme(darkTheme),
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
