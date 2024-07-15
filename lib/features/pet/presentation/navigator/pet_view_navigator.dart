import 'package:final_assignment/features/single_pet/presentation/navigator/single_pet_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final petNavigatorProvider = Provider((ref) => PetViewNavigator());

class PetViewNavigator with SinglePetViewRoute {}

mixin PetViewRoute {}
