import 'package:final_assignment/features/single_pet/presentation/navigator/single_pet_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final singlePetViewModelProvider =
    StateNotifierProvider<SinglePetViewModel, void>(
  (ref) => SinglePetViewModel(
    singlePetViewNavigator: ref.read(singlePetViewNavigatorProvider),
  ),
);

class SinglePetViewModel extends StateNotifier<void> {
  SinglePetViewModel({required this.singlePetViewNavigator}) : super(null);

  final SinglePetViewNavigator singlePetViewNavigator;

  void openPetView() {
    singlePetViewNavigator.openDashboardView(index: 1);
  }
}
