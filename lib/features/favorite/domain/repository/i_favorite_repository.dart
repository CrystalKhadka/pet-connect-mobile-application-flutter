import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favorite/data/repository/favorite_api_repository.dart';
import 'package:final_assignment/features/favorite/domain/entity/favorite_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteRepositoryProvider = Provider<IFavoriteRepository>(
  (ref) => ref.read(favoriteApiRepositoryProvider),
);

abstract class IFavoriteRepository {
  Future<Either<Failure, bool>> addFavorite(String petId);

  Future<Either<Failure, bool>> removeFavorite(String petId);

  Future<Either<Failure, List<FavoriteEntity>>> getFavoritePets();
}
