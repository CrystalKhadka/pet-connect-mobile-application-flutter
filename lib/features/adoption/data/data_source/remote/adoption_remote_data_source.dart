import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/adoption/data/model/adoption_api_model.dart';
import 'package:final_assignment/features/adoption/domain/entity/adoption_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adoptionRemoteDataSourceProvider = Provider<AdoptionRemoteDataSource>(
  (ref) => AdoptionRemoteDataSource(
    dio: ref.watch(httpServiceProvider),
    adoptionApiModel: ref.watch(adoptionApiModelProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  ),
);

class AdoptionRemoteDataSource {
  final Dio dio;
  final AdoptionApiModel adoptionApiModel;
  final UserSharedPrefs userSharedPrefs;

  AdoptionRemoteDataSource(
      {required this.dio,
      required this.adoptionApiModel,
      required this.userSharedPrefs});

  Future<Either<Failure, bool>> addAdoptions(AdoptionEntity entity) async {
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
      final model = AdoptionApiModel.fromEntity(entity);
      final response = await dio.post(ApiEndpoints.addAdoption,
          data: model.toJson(),
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
            statusCode: response.statusCode.toString()),
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
