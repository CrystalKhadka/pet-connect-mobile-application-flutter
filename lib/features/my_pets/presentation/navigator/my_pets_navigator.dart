import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/my_pets/presentation/view/my_pets_view.dart';

class MyPetsViewNavigator {}

mixin MyPetsViewRoute {
  openMyPetsView() {
    NavigateRoute.pushRoute(const MyPetsView());
  }
}
