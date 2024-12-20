import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/chat/presentation/navigator/chat_navigator.dart';
import 'package:final_assignment/features/home/presentation/view/dashboard_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
final dashboardNavigatorProvider =
    Provider<DashboardViewNavigator>((ref) => DashboardViewNavigator());

class DashboardViewNavigator with LoginViewRoute, ChatViewRoute {}

mixin DashboardViewRoute {
  openDashboardView({int? index}) {
    NavigateRoute.popAndPushRoute(DashboardView(
      index: index,
    ));
  }
}
