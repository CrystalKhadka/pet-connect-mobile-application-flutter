import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:final_assignment/features/pet/domain/repository/i_pet_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final petUseCaseProvider = Provider<PetUseCase>((ref) {
  final petRepository = ref.watch(petRepositoryProvider);
  return PetUseCase(petRepository: petRepository);
});

class PetUseCase {
  final IPetRepository petRepository;

  PetUseCase({
    required this.petRepository,
  });

  Future<Either<Failure, List<PetEntity>>> pagination(
      int page, int limit, String search, String breed) {
    return petRepository.pagination(page, limit, search, breed);
  }

  Future<Either<Failure, List<String>>> getAllSpecies() {
    return petRepository.getAllSpecies();
  }

  Future<Either<Failure, PetEntity>> getPetById(String id) {
    return petRepository.getPetById(id);
  }
}
