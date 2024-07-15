import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/single_pet/presentation/view/single_pet_view.dart';

class SinglePetViewNavigator {}

mixin SinglePetViewRoute {
  openSinglePetView() {
    NavigateRoute.pushRoute(const SinglePetView());
  }
}
