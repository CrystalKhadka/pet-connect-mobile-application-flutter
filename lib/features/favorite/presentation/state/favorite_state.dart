import 'package:final_assignment/features/favorite/domain/entity/favorite_entity.dart';

class FavoriteState {
  final String error;
  final bool isLoading;
  final List<FavoriteEntity> favorites;

  FavoriteState({
    required this.error,
    required this.isLoading,
    required this.favorites,
  });

  factory FavoriteState.initial() {
    return FavoriteState(
      error: '',
      isLoading: false,
      favorites: [],
    );
  }

  FavoriteState copyWith({
    String? error,
    bool? isLoading,
    List<FavoriteEntity>? favorites,
  }) {
    return FavoriteState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      favorites: favorites ?? this.favorites,
    );
  }
}
