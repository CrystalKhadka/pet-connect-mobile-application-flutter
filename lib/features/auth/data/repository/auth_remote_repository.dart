import 'dart:io';

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

  @override
  Future<Either<Failure, bool>> fingerPrintLogin(String id) {
    return authRemoteDataSource.fingerPrintLogin(id);
  }

  @override
  Future<Either<Failure, List<AuthEntity>>> getAllUser() {
    return authRemoteDataSource.getAllUsers();
  }

  @override
  Future<Either<Failure, AuthEntity>> getUser(String id) {
    return authRemoteDataSource.getUser(id);
  }

  @override
  Future<Either<Failure, AuthEntity>> getUserByGoogle(String token) {
    return authRemoteDataSource.getUserByGoogle(token);
  }

  @override
  Future<Either<Failure, bool>> googleLogin(String token, String? password) {
    return authRemoteDataSource.googleLogin(token, password);
  }

  @override
  Future<Either<Failure, String>> uploadImage(File file) {
    return authRemoteDataSource.uploadImage(file);
  }

  @override
  Future<Either<Failure, bool>> updateUser(AuthEntity user) {
    return authRemoteDataSource.updateProfile(user);
  }

  @override
  Future<Either<Failure, bool>> sendEmail(String email) {
    return authRemoteDataSource.sendEmail(email);
  }

  @override
  Future<Either<Failure, bool>> sendOtp(String phone) {
    return authRemoteDataSource.sendOtp(phone);
  }

  @override
  Future<Either<Failure, bool>> resetPass(
      {required String phone, required String password, required String otp}) {
    return authRemoteDataSource.resetPassFromOtp(
        phone: phone, password: password, otp: otp);
  }

  @override
  Future<Either<Failure, bool>> changePassword(
      {required String oldPassword, required String newPassword}) {
    return authRemoteDataSource.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }
}
