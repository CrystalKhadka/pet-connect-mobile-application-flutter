import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';

class LoginViewNavigator with RegisterViewRoute {}

mixin LoginViewROute {
  openLoginView() {
    NavigateRoute.popAndPushRoute(const LoginView());
  }
}
