import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/pet/data/repository/pet_local_repository.dart';
import 'package:final_assignment/features/pet/data/repository/pet_remote_repository.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/internet_connectivity.dart';

final petRepositoryProvider = Provider<IPetRepository>((ref) {
  final checkConnectivity = ref.watch(connectivityStatusProvider);
  if (checkConnectivity == ConnectivityStatus.isConnected) {
    return ref.read(petRemoteRepository);
  } else {
    return ref.read(petLocalRepositoryProvider);
  }
});

abstract class IPetRepository {
  Future<Either<Failure, List<PetEntity>>> pagination(
      int page, int limit, String search, String breed);

  Future<Either<Failure, List<String>>> getAllSpecies();

  Future<Either<Failure, PetEntity>> getPetById(String id);
}
