import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/my_pets/presentation/view/my_pets_view.dart';
import 'package:final_assignment/features/payment/presentation/navigator/payment_navigator.dart';
import 'package:final_assignment/features/single_pet/presentation/navigator/single_pet_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myPetsViewNavigatorProvider = Provider<MyPetsViewNavigator>(
  (ref) => MyPetsViewNavigator(),
);

class MyPetsViewNavigator with SinglePetViewRoute, PaymentViewRoute {}

mixin MyPetsViewRoute {
  openMyPetsView() {
    NavigateRoute.pushRoute(const MyPetsView());
  }
}
