import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/edit_profile/presentation/navigator/edit_profile_navigator.dart';
import 'package:final_assignment/features/favorite/presentation/navigator/favorite_navigator.dart';
import 'package:final_assignment/features/profile/presentation/view/profile_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../my_pets/presentation/navigator/my_pets_navigator.dart';

final profileNavigatorProvider = Provider<ProfileViewNavigator>((ref) {
  return ProfileViewNavigator();
});

class ProfileViewNavigator
    with FavoriteViewRoute, EditProfileRoute, MyPetsViewRoute {}

mixin ProfileViewRoute {
  void openProfileView() {
    NavigateRoute.popAndPushRoute(const ProfileView());
  }
}
