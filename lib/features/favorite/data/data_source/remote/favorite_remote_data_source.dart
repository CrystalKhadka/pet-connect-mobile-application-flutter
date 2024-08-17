import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/favorite/data/dto/get_favorite_dto.dart';
import 'package:final_assignment/features/favorite/data/model/favorite_api_model.dart';
import 'package:final_assignment/features/favorite/domain/entity/favorite_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteRemoteDataSourceProvider = Provider<FavoriteRemoteDataSource>(
  (ref) => FavoriteRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    favoriteApiModel: ref.read(favoriteApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class FavoriteRemoteDataSource {
  final Dio dio;
  final FavoriteApiModel favoriteApiModel;

  final UserSharedPrefs userSharedPrefs;
  FavoriteRemoteDataSource({
    required this.dio,
    required this.favoriteApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addFavorite(String petId) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) {
          throw l;
        },
        (r) {
          token = r;
        },
      );
      final response = await dio.post(ApiEndpoints.addFavorite,
          data: {
            'petId': petId,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 201) {
        return const Right(true);
      }
      return Left(
        Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(
        Failure(error: e.error.toString()),
      );
    } catch (e) {
      return Left(
        Failure(error: e.toString()),
      );
    }
  }

  Future<Either<Failure, bool>> removeFavorite(String petId) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) {
          throw l;
        },
        (r) {
          token = r;
        },
      );
      final response = await dio.delete('${ApiEndpoints.deleteFavorite}$petId',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        return const Right(true);
      }
      return Left(
        Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(
        Failure(error: e.error.toString()),
      );
    } catch (e) {
      return Left(
        Failure(error: e.toString()),
      );
    }
  }

  Future<Either<Failure, List<FavoriteEntity>>> getFavorites() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) {
          throw l;
        },
        (r) {
          token = r;
        },
      );
      final response = await dio.get(ApiEndpoints.getFavorite,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        final getFavoriteDto = GetFavoriteDto.fromJson(response.data);
        final favorites = getFavoriteDto.favorites;
        return Right(
          favoriteApiModel.toEntities(favorites),
        );
      }
      return Left(
        Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(
        Failure(error: e.error.toString()),
      );
    } catch (e) {
      return Left(
        Failure(error: e.toString()),
      );
    }
  }
}
