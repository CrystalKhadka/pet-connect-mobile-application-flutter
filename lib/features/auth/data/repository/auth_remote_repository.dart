import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>(
  (ref) => AuthRemoteRepository(
    authRemoteDataSource: ref.read(authRemoteDataSourceProvider),
  ),
);

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRemoteRepository({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return authRemoteDataSource.loginUser(email: email, password: password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) {
    return authRemoteDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, bool>> verifyUser() {
    return authRemoteDataSource.verifyUser();
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    return authRemoteDataSource.getMe();
  }
}
