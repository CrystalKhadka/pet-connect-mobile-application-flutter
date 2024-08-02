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
  PetViewModel({
    required this.petUseCase,
    required this.petViewNavigator,
    required this.favoriteUsecase,
  }) : super(PetState.initial()) {
    _initializeData();
  }

  final PetUseCase petUseCase;
  final PetViewNavigator petViewNavigator;
  final FavoriteUsecase favoriteUsecase;

  Future<void> _initializeData() async {
    await Future.wait([
      fetchPets(),
      fetchSpecies(),
      fetchFavoritePets(),
    ]);
  }

  Future<void> resetState() async {
    state = PetState.initial();
    await _initializeData();
  }

  Future<void> fetchPets() async {
    if (state.hasReachedMax) return;

    state = state.copyWith(isLoading: true);
    final result = await petUseCase.pagination(
      state.page + 1,
      state.limit,
      state.searchQuery,
      state.selectedSpecies,
    );

    result.fold(
      (failure) => state = state.copyWith(
        hasReachedMax: true,
        isLoading: false,
        error: failure.error,
      ),
      (data) {
        final newPets = [...state.pets, ...data];
        state = state.copyWith(
          pets: newPets,
          page: state.page + 1,
          isLoading: false,
          hasReachedMax: data.isEmpty,
        );
      },
    );
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

  Future<void> searchPets(String query) async {
    state = state.copyWith(
      searchQuery: query,
      page: 0,
      pets: [],
      hasReachedMax: false,
    );
    await fetchPets();
  }

  Future<void> filterPets(String species) async {
    state = state.copyWith(
      selectedSpecies: species,
      page: 0,
      pets: [],
      hasReachedMax: false,
    );
    await fetchPets();
  }

  Future<void> toggleFavorite(PetEntity entity) async {
    state = state.copyWith(isLoading: true);
    final isFavorite = state.favorites.contains(entity.id);
    final result = isFavorite
        ? await favoriteUsecase.removeFavorite(entity.id ?? '')
        : await favoriteUsecase.addFavorite(entity.id ?? '');

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (_) {
        final updatedFavorites = isFavorite
            ? state.favorites.where((id) => id != entity.id).toList()
            : [...state.favorites, entity.id!];
        state = state.copyWith(
          isLoading: false,
          favorites: updatedFavorites,
        );
        if (!isFavorite) {
          showMySnackBar(message: 'Added to favorite', color: Colors.green);
        }
      },
    );
  }

  Future<void> fetchFavoritePets() async {
    final result = await favoriteUsecase.getFavoritePets();
    result.fold(
      (failure) {
        state = state.copyWith(error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (data) => state = state.copyWith(
        favorites: data.map((e) => e.pet.id!).toList(),
      ),
    );
  }

  bool isFavorite(PetEntity entity) => state.favorites.contains(entity.id);

  void openSinglePetView(String id) => petViewNavigator.openSinglePetView(id);

  void openAdoptionForm(String id) => petViewNavigator.openAdoptionFormView(id);
}
