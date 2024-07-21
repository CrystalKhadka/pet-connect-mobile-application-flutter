import 'package:final_assignment/features/favorite/domain/usecases/favorite_usecase.dart';
import 'package:final_assignment/features/favorite/presentation/state/favorite_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteViewModelProvider =
    StateNotifierProvider<FavoriteViewModel, FavoriteState>(
  (ref) => FavoriteViewModel(
    favoriteUsecase: ref.read(favoriteUsecaseProvider),
  ),
);

class FavoriteViewModel extends StateNotifier<FavoriteState> {
  FavoriteViewModel({required this.favoriteUsecase})
      : super(FavoriteState.initial()) {
    fetchFavoritePets();
  }

  final FavoriteUsecase favoriteUsecase;

  Future<void> fetchFavoritePets() async {
    state = FavoriteState.initial();
    state = state.copyWith(isLoading: true);
    final favorites = state.favorites;
    final result = await favoriteUsecase.getFavoritePets();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) {
        state = state.copyWith(isLoading: false, favorites: [
          ...favorites,
          ...data,
        ]);
      },
    );
  }

  Future<void> toggleFavorite(String petId) async {
    final result = await favoriteUsecase.removeFavorite(petId);
    result.fold(
      (failure) => state = state.copyWith(
        error: failure.error,
      ),
      (data) {
        fetchFavoritePets();
      },
    );
  }
}
