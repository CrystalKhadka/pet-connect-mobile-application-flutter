import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/edit_profile/presentation/view/edit_profile_view.dart';

class EditProfileViewNavigator {}

mixin EditProfileRoute {
  openEditProfileView() {
    NavigateRoute.pushRoute(const EditProfileView());
  }
}
