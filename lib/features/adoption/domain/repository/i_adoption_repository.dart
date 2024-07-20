import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/adoption/data/repository/adoption_remote_repository.dart';
import 'package:final_assignment/features/adoption/domain/entity/adoption_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adoptionRepositoryProvider = Provider<IAdoptionRepository>(
  (ref) => ref.read(adoptionRemoteRepositoryProvider),
);

abstract class IAdoptionRepository {
  Future<Either<Failure, bool>> addAdoptionForm(AdoptionEntity adoptionEntity);
}
