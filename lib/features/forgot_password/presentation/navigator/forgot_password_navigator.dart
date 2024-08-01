import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/forgot_password/presentation/view/forgot_password_view.dart';

class ForgotPasswordViewNavigator {}

mixin ForgotPasswordRoute {
  void openForgotPasswordView() {
    NavigateRoute.pushRoute(const ForgotPasswordView());
  }
}
