import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/pet/data/dto/get_single_pet_dto.dart';
import 'package:final_assignment/features/pet/data/dto/pagination_dto.dart';
import 'package:final_assignment/features/pet/data/model/pet_api_model.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared_prefs/user_shared_prefs.dart';

final petRemoteDataSourceProvider = Provider<PetRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final petApiModel = ref.watch(petApiModelProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return PetRemoteDataSource(
    dio: dio,
    petApiModel: petApiModel,
    userSharedPrefs: userSharedPrefs,
  );
});

class PetRemoteDataSource {
  final Dio dio;
  final PetApiModel petApiModel;
  final UserSharedPrefs userSharedPrefs;

  PetRemoteDataSource({
    required this.dio,
    required this.petApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<PetEntity>>> pagination(
      {required int page,
      required int limit,
      required String search,
      required String breed}) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      token.fold((l) => throw Failure(error: l.error), (r) => r);
      final response = await dio.get(
        ApiEndpoints.pagination,
        queryParameters: {
          'page': page,
          'limit': limit,
          'search': search,
          'species': breed,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final paginationDto = PaginationDto.fromJson(response.data);
        return Right(petApiModel.toEntities(paginationDto.pets));
      }
      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, List<String>>> getAllSpecies() async {
    try {
      final token = await userSharedPrefs.getUserToken();
      token.fold((l) => throw Failure(error: l.error), (r) => r);
      final response = await dio.get(
        ApiEndpoints.getAllSpecies,
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final List<String> species =
            List<String>.from(response.data['species']);
        return Right(species);
      }
      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  // Get by id
  Future<Either<Failure, PetEntity>> getPetById({required String id}) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold((l) => throw Failure(error: l.error), (r) => token = r);
      final response = await dio.get(
        ApiEndpoints.getPetById + id,
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final data = GetSinglePetDto.fromJson(response.data).data;
        final pet = data.toEntity();
        return Right(pet);
      }
      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
}
