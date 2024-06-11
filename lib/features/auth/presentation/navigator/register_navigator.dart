import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/register_view.dart';

class RegisterViewNavigator with LoginViewRoute {}

mixin RegisterViewRoute {
  openRegisterView() {
    NavigateRoute.popAndPushRoute(const RegisterView());
  }
}
