import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favorite/data/data_source/remote/favorite_remote_data_source.dart';
import 'package:final_assignment/features/favorite/domain/entity/favorite_entity.dart';
import 'package:final_assignment/features/favorite/domain/repository/i_favorite_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteApiRepositoryProvider = Provider<IFavoriteRepository>(
  (ref) => FavoriteApiRepository(
    ref.read(
      favoriteRemoteDataSourceProvider,
    ),
  ),
);

class FavoriteApiRepository implements IFavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;

  FavoriteApiRepository(this.remoteDataSource);
  @override
  Future<Either<Failure, bool>> addFavorite(String petId) {
    return remoteDataSource.addFavorite(petId);
  }

  @override
  Future<Either<Failure, bool>> removeFavorite(String petId) {
    return remoteDataSource.removeFavorite(petId);
  }

  @override
  Future<Either<Failure, List<FavoriteEntity>>> getFavoritePets() {
    return remoteDataSource.getFavorites();
  }
}
