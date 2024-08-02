import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/pet/data/data_source/remote/pet_remote_data_source.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:final_assignment/features/pet/domain/repository/i_pet_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final petRemoteRepository = Provider<IPetRepository>((ref) {
  final petRemoteDataSource = ref.watch(petRemoteDataSourceProvider);
  return PetRemoteRepository(petRemoteDataSource: petRemoteDataSource);
});

class PetRemoteRepository implements IPetRepository {
  final PetRemoteDataSource petRemoteDataSource;

  PetRemoteRepository({required this.petRemoteDataSource});

  @override
  Future<Either<Failure, List<PetEntity>>> pagination(
      int page, int limit, String search, String breed) {
    return petRemoteDataSource.pagination(
        page: page, limit: limit, search: search, breed: breed);
  }

  @override
  Future<Either<Failure, List<String>>> getAllSpecies() {
    return petRemoteDataSource.getAllSpecies();
  }

  @override
  Future<Either<Failure, PetEntity>> getPetById(String id) {
    return petRemoteDataSource.getPetById(id: id);
  }
}
