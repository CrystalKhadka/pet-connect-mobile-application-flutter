import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/favorite/domain/usecases/favorite_usecase.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:final_assignment/features/pet/domain/usecases/pet_usecase.dart';
import 'package:final_assignment/features/pet/presentation/navigator/pet_view_navigator.dart';
import 'package:final_assignment/features/pet/presentation/state/pet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final petViewModelProvider = StateNotifierProvider<PetViewModel, PetState>(
  (ref) => PetViewModel(
    petUseCase: ref.read(petUseCaseProvider),
    petViewNavigator: ref.read(petNavigatorProvider),
    favoriteUsecase: ref.read(favoriteUsecaseProvider),
  ),
);

class PetViewModel extends StateNotifier<PetState> {
  PetViewModel(
      {required this.petUseCase,
      required this.petViewNavigator,
      required this.favoriteUsecase})
      : super(PetState.initial()) {
    fetchPets(state.limit);
    fetchSpecies();

    fetchFavoritePets();
  }

  final PetUseCase petUseCase;
  final PetViewNavigator petViewNavigator;
  final FavoriteUsecase favoriteUsecase;

  Future<void> resetState() async {
    state = PetState.initial();
    fetchFavoritePets();
    fetchPets(state.limit);
    fetchSpecies();
  }

  Future<void> fetchPets(int limit) async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final pets = currentState.pets;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source

      final result = await petUseCase.pagination(page, limit);
      result.fold(
        (failure) => state = state.copyWith(
          hasReachedMax: true,
          isLoading: false,
          error: failure.error,
        ),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              pets: [...pets, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    } else {
      state = state.copyWith(isLoading: false);
      // showMySnackBar(message: 'No more data to load.', color: Colors.red);
    }
  }

  Future<void> fetchSpecies() async {
    final result = await petUseCase.getAllSpecies();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(species: data),
    );
  }

  Future<void> toggleFavorite(PetEntity entity) async {
    state = state.copyWith(isLoading: true);
    if (isFavorite(entity)) {
      final result = await favoriteUsecase.removeFavorite(entity.id ?? '');
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
      final result = await favoriteUsecase.addFavorite(entity.id ?? '');
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
    fetchFavoritePets();
  }

  fetchFavoritePets() async {
    final result = await favoriteUsecase.getFavoritePets();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (data) => state = state.copyWith(
          favorites: data
              .map(
                (e) => e.pet.id!,
              )
              .toList()),
    );
  }

  // compare favorite pets with all pets
  bool isFavorite(PetEntity entity) {
    print(state.favorites);
    print(entity.id);
    return state.favorites.contains(entity.id);
  }

  void openSinglePetView(String id) {
    petViewNavigator.openSinglePetView(id);
  }

  void openAdoptionForm(String id) {
    petViewNavigator.openAdoptionFormView(id);
  }
}
