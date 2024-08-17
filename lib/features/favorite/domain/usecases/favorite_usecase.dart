import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favorite/domain/entity/favorite_entity.dart';
import 'package:final_assignment/features/favorite/domain/repository/i_favorite_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteUsecaseProvider = Provider<FavoriteUsecase>(
  (ref) => FavoriteUsecase(
    repository: ref.read(favoriteRepositoryProvider),
  ),
);

class FavoriteUsecase {
  final IFavoriteRepository repository;

  FavoriteUsecase({required this.repository});

  Future<Either<Failure, bool>> addFavorite(String? petId) async {
    return repository.addFavorite(petId ?? '');
  }

  Future<Either<Failure, bool>> removeFavorite(String petId) {
    return repository.removeFavorite(petId);
  }

  Future<Either<Failure, List<FavoriteEntity>>> getFavoritePets() {
    return repository.getFavoritePets();
  }
}
