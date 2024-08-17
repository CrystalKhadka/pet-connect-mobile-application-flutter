import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/local/hive_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/pet_entity.dart';
import '../../model/pet_hive_model.dart';

final petLocalDataSourceProvider =
    Provider((ref) => PetLocalDataSource(ref.read(hiveServiceProvider)));

class PetLocalDataSource {
  final HiveService hiveService;

  PetLocalDataSource(this.hiveService);

//   save all pets
  static Future<Either<Failure, bool>> savePets(List<PetEntity> pets) async {
    try {
      final hivePets = pets.map((e) => PetHiveModel.fromEntity(e)).toList();
      await HiveService.saveAllPets(hivePets);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

//   get all pets
  Future<Either<Failure, List<PetEntity>>> getAllPets() async {
    try {
      final pets = await hiveService.getAllPets();
      return Right(pets.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
