import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/home/presentation/navigator/dashboard_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewNavigatorProvider =
    Provider<SplashViewNavigator>((ref) => SplashViewNavigator());

class SplashViewNavigator with LoginViewRoute, DashboardViewRoute {}

mixin SplashRoute {}
