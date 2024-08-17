import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/common/provider/internet_connectivity.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/data/repository/auth_local_repository.dart';
import 'package:final_assignment/features/auth/data/repository/auth_remote_repository.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final checkConnectivity = ref.watch(connectivityStatusProvider);
  if (checkConnectivity == ConnectivityStatus.isConnected) {
    return ref.read(authRemoteRepositoryProvider);
  } else {
    return ref.read(authLocalRepositoryProvider);
  }
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(AuthEntity user);

  Future<Either<Failure, bool>> loginUser(String email, String password);

  Future<Either<Failure, bool>> googleLogin(String token, String? password);

  Future<Either<Failure, bool>> verifyUser();

  Future<Either<Failure, AuthEntity>> getCurrentUser();

  Future<Either<Failure, bool>> fingerPrintLogin(String id);

  Future<Either<Failure, AuthEntity>> getUser(String id);

  Future<Either<Failure, AuthEntity>> getUserByGoogle(String token);

  Future<Either<Failure, List<AuthEntity>>> getAllUser();

  Future<Either<Failure, String>> uploadImage(File file);

  Future<Either<Failure, bool>> updateUser(AuthEntity user);

  Future<Either<Failure, bool>> sendEmail(String email);

  Future<Either<Failure, bool>> sendOtp(String phone);

  Future<Either<Failure, bool>> resetPass({
    required String phone,
    required String password,
    required String otp,
  });

  Future<Either<Failure, bool>> changePassword(
      {required String oldPassword, required String newPassword});
}
