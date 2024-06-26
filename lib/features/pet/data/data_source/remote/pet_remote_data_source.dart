import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/pet/data/dto/pagination_dto.dart';
import 'package:final_assignment/features/pet/data/model/pet_api_model.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final petRemoteDataSourceProvider = Provider<PetRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final petApiModel = ref.watch(petApiModelProvider);
  return PetRemoteDataSource(
    dio: dio,
    petApiModel: petApiModel,
  );
});

class PetRemoteDataSource {
  final Dio dio;
  final PetApiModel petApiModel;

  PetRemoteDataSource({
    required this.dio,
    required this.petApiModel,
  });

  Future<Either<Failure, List<PetEntity>>> pagination({required int page,required int limit}) async {
    try {
      final response = await dio.get(
        ApiEndpoints.pagination,
        queryParameters: {'page': page, 'limit': 3},
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
}
