import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/home/presentation/navigator/dashboard_navigator.dart';
import 'package:final_assignment/features/single_pet/presentation/view/single_pet_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final singlePetViewNavigatorProvider =
    Provider((ref) => SinglePetViewNavigator());

class SinglePetViewNavigator with DashboardViewRoute {}

mixin SinglePetViewRoute {
  openSinglePetView(String id) {
    NavigateRoute.pushRoute(SinglePetView(
      id: id,
    ));
  }
}
