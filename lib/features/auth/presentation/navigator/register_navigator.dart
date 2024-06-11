import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/register_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerNavigatorProvider =
    Provider<RegisterViewNavigator>((ref) => RegisterViewNavigator());

class RegisterViewNavigator with LoginViewRoute {}

mixin RegisterViewRoute {
  openRegisterView() {
    NavigateRoute.popAndPushRoute(const RegisterView());
  }
}
