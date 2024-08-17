import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:final_assignment/features/pet/domain/repository/i_pet_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_source/local/pet_local_data_source.dart';

final petLocalRepositoryProvider = Provider(
  (ref) => PetLocalRepository(ref.read(petLocalDataSourceProvider)),
);

class PetLocalRepository implements IPetRepository {
  final PetLocalDataSource petLocalDataSource;

  PetLocalRepository(this.petLocalDataSource);

  @override
  Future<Either<Failure, List<String>>> getAllSpecies() {
    // TODO: implement getAllSpecies
    throw Failure(error: "No connection");
  }

  @override
  Future<Either<Failure, PetEntity>> getPetById(String id) {
    // TODO: implement getPetById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PetEntity>>> pagination(
      int page, int limit, String search, String breed) {
    return petLocalDataSource.getAllPets();
  }
}
