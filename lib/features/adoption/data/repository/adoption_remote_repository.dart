import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/adoption/data/data_source/remote/adoption_remote_data_source.dart';
import 'package:final_assignment/features/adoption/domain/entity/adoption_entity.dart';
import 'package:final_assignment/features/adoption/domain/repository/i_adoption_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adoptionRemoteRepositoryProvider = Provider<IAdoptionRepository>(
  (ref) => AdoptionRemoteRepository(
    ref.watch(adoptionRemoteDataSourceProvider),
  ),
);

class AdoptionRemoteRepository implements IAdoptionRepository {
  final AdoptionRemoteDataSource adoptionRemoteDataSource;

  AdoptionRemoteRepository(
    this.adoptionRemoteDataSource,
  );

  @override
  Future<Either<Failure, bool>> addAdoptionForm(AdoptionEntity adoptionEntity) {
    return adoptionRemoteDataSource.addAdoptions(adoptionEntity);
  }

  @override
  Future<Either<Failure, List<AdoptionEntity>>> getAdoptionsByUser() {
    return adoptionRemoteDataSource.getAdoptions();
  }
}
