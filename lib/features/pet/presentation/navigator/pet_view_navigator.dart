import 'package:final_assignment/features/adoption/presentation/navigator/adoption_form_navigator.dart';
import 'package:final_assignment/features/single_pet/presentation/navigator/single_pet_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final petNavigatorProvider = Provider((ref) => PetViewNavigator());

class PetViewNavigator with SinglePetViewRoute, AdoptionFormRoute {}

mixin PetViewRoute {}
