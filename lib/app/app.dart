import 'package:final_assignment/app/themes/app_theme.dart';
import 'package:final_assignment/core/common/provider/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:light_sensor/light_sensor.dart';

import '../features/splash/presentation/view/splash_screen.dart';
import 'navigator_key/navigator_key.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  void _initializeLightSensor() async {
    final bool hasSensor = await LightSensor.hasSensor();
    if (hasSensor) {
      LightSensor.luxStream().listen((int lux) {
        final isDarkMode = lux < 40;

        ref.read(themeViewModelProvider.notifier).setDarkTheme(isDarkMode);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeLightSensor();
  }

  @override
  Widget build(BuildContext context) {
    final themeViewModel = ref.watch(themeViewModelProvider);
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Pet Adoption App',
      theme: AppTheme.getApplicationTheme(
        themeViewModel.isDarkMode,
      ),
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
