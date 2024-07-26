import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/favorite/domain/usecases/favorite_usecase.dart';
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
    favoriteUsecase: ref.read(favoriteUsecaseProvider),
  ),
);

class SinglePetViewModel extends StateNotifier<SinglePetState> {
  SinglePetViewModel({
    required this.singlePetViewNavigator,
    required this.petUseCase,
    required this.favoriteUsecase,
  }) : super(
          SinglePetState.initial(),
        );

  final SinglePetViewNavigator singlePetViewNavigator;
  final PetUseCase petUseCase;
  final FavoriteUsecase favoriteUsecase;

  void openPetView() {
    singlePetViewNavigator.openDashboardView(index: 1);
  }

  void openAdoptionForm() {
    singlePetViewNavigator.openAdoptionFormView(state.petEntity!.id!);
  }

  void openChatView() {
    singlePetViewNavigator.openChatView(id: state.petEntity?.createdBy?.id);
  }

  void init(String id) {
    fetchPetById(id);
    checkFavorite();
  }

  checkFavorite() async {
    final result = await favoriteUsecase.getFavoritePets();
    result.fold(
      (failure) {
        state = state.copyWith(
          error: failure.error,
        );
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (data) {
        final isFavorite =
            data.any((element) => element.pet.id == state.petEntity!.id);
        state = state.copyWith(
          isFavorite: isFavorite,
        );
      },
    );
  }

  Future<void> toggleFavorite(String id) async {
    state = state.copyWith(isLoading: true);
    if (state.isFavorite) {
      final result = await favoriteUsecase.removeFavorite(id);
      result.fold(
        (failure) => state = state.copyWith(
          isLoading: false,
          error: failure.error,
        ),
        (data) {
          state = state.copyWith(
            isLoading: false,
          );
        },
      );
    } else {
      final result = await favoriteUsecase.addFavorite(id);
      result.fold((failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error, color: Colors.red);
      }, (data) {
        state = state.copyWith(
          isLoading: false,
        );

        showMySnackBar(message: 'Added to favorite', color: Colors.green);
      });
    }
    init(id);
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
