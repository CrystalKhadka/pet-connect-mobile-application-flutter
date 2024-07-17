import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/pet/domain/usecases/pet_usecase.dart';
import 'package:final_assignment/features/single_pet/presentation/navigator/single_pet_navigator.dart';
import 'package:final_assignment/features/single_pet/presentation/state/single_pet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final singlePetViewModelProvider =
    StateNotifierProvider<SinglePetViewModel, SinglePetState>(
  (ref) => SinglePetViewModel(
    singlePetViewNavigator: ref.read(singlePetViewNavigatorProvider),
    petUseCase: ref.read(petUseCaseProvider),
  ),
);

class SinglePetViewModel extends StateNotifier<SinglePetState> {
  SinglePetViewModel({
    required this.singlePetViewNavigator,
    required this.petUseCase,
  }) : super(
          SinglePetState.initial(),
        );

  final SinglePetViewNavigator singlePetViewNavigator;
  final PetUseCase petUseCase;

  void openPetView() {
    singlePetViewNavigator.openDashboardView(index: 1);
  }

  Future<void> fetchPetById(String id) async {
    state = state.copyWith(isLoading: true);
    final result = await petUseCase.getPetById(id);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (data) {
        state = state.copyWith(
          isLoading: false,
          petEntity: data,
        );
      },
    );
  }
}
