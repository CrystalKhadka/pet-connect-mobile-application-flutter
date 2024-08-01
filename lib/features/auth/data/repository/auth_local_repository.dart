import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/data/data_source/local/auth_local_data_source.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthLocalRepository(
      authLocalDataSource: ref.read(authLocalDataSourceProvider));
});

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  AuthLocalRepository({required this.authLocalDataSource});

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) {
    return authLocalDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return authLocalDataSource.loginUser(email, password);
  }

  @override
  Future<Either<Failure, bool>> verifyUser() {
    // TODO: implement verifyUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> fingerPrintLogin(String id) {
    // TODO: implement fingerPrintLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AuthEntity>>> getAllUser() {
    // TODO: implement getAllUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> getUser(String id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> getUserByGoogle(String token) {
    // TODO: implement getUserByGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> googleLogin(String token, String? password) {
    // TODO: implement googleLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadImage(File file) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateUser(AuthEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> sendEmail(String email) {
    // TODO: implement sendEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> sendOtp(String phone) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> resetPass(
      {required String phone, required String password, required String otp}) {
    // TODO: implement resetPass
    throw UnimplementedError();
  }
}
