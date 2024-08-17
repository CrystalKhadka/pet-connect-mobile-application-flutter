import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/adoption/domain/entity/adoption_entity.dart';
import 'package:final_assignment/features/adoption/domain/repository/i_adoption_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adoptionUseCaseProvider = Provider<AdoptionUsecase>(
  (ref) => AdoptionUsecase(
    ref.read(adoptionRepositoryProvider),
  ),
);

class AdoptionUsecase {
  final IAdoptionRepository adoptionRepository;

  AdoptionUsecase(this.adoptionRepository);

  Future<Either<Failure, bool>> addAdoptionForm(AdoptionEntity entity) async {
    return await adoptionRepository.addAdoptionForm(entity);
  }

  Future<Either<Failure, List<AdoptionEntity>>> getAdoptionsByUser() async {
    return await adoptionRepository.getAdoptionsByUser();
  }
}
