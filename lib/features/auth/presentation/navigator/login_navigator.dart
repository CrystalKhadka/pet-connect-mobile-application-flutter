import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:final_assignment/features/forgot_password/presentation/navigator/forgot_password_navigator.dart';
import 'package:final_assignment/features/home/presentation/navigator/dashboard_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginNavigatorProvider =
    Provider<LoginViewNavigator>((ref) => LoginViewNavigator());

class LoginViewNavigator
    with RegisterViewRoute, DashboardViewRoute, ForgotPasswordRoute {}

mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.popAndPushRoute(const LoginView());
  }
}
