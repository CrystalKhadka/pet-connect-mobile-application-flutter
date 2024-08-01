import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/shared_prefs/user_shared_prefs.dart';

final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  return AuthUseCase(
      authRepository: ref.watch(authRepositoryProvider),
      userSharedPrefs: ref.watch(userSharedPrefsProvider));
});

class AuthUseCase {
  final IAuthRepository authRepository;
  final UserSharedPrefs userSharedPrefs;

  AuthUseCase({required this.authRepository, required this.userSharedPrefs});

  Future<Either<Failure, bool>> registerUser(AuthEntity? auth) {
    return authRepository.registerUser(auth ?? const AuthEntity.empty());
  }

  Future<Either<Failure, bool>> loginUser(String? email, String? password) {
    return authRepository.loginUser(email ?? '', password ?? '');
  }

  Future<Either<Failure, bool>> googleLogin(String? token, String? password) {
    return authRepository.googleLogin(token ?? '', password);
  }

  Future<Either<Failure, bool>> verifyUser() {
    return authRepository.verifyUser();
  }

  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    return authRepository.getCurrentUser();
  }

  Future<Either<Failure, String>> getFingerPrintId() async {
    return userSharedPrefs.checkId();
  }

  Future<Either<Failure, bool>> saveFingerPrintId(String? id) async {
    final data = await userSharedPrefs.saveFingerPrintId(id ?? '');
    return data.fold(
      (l) => Left(Failure(error: l.error)),
      (r) => Right(r),
    );
  }

  Future<Either<Failure, bool>> fingerPrintLogin() async {
    final data = await userSharedPrefs.checkId();
    return data.fold((l) => Left(Failure(error: l.error)), (r) async {
      if (r != '') {
        await authRepository.fingerPrintLogin(r);
        return const Right(true);
      }
      return Left(Failure(error: 'No fingerprint id found'));
    });
  }

  // get all users
  Future<Either<Failure, List<AuthEntity>>?> getAllUsers() async {
    return authRepository.getAllUser();
  }

  // get user by id
  Future<Either<Failure, AuthEntity>> getUser(String id) {
    return authRepository.getUser(id);
  } // get user by id

  Future<Either<Failure, AuthEntity>> getUserByGoogle(String token) {
    return authRepository.getUserByGoogle(token);
  }

  Future<Either<Failure, String>> uploadImage(File file) {
    return authRepository.uploadImage(file);
  }

  Future<Either<Failure, bool>> updateUser(AuthEntity user) {
    return authRepository.updateUser(user);
  }

  Future<Either<Failure, bool>> sendEmail(String email) {
    return authRepository.sendEmail(email);
  }

  Future<Either<Failure, bool>> sendOtp(String phone) {
    return authRepository.sendOtp(phone);
  }

  Future<Either<Failure, bool>> resetPass({
    required String phone,
    required String password,
    required String otp,
  }) {
    return authRepository.resetPass(phone: phone, password: password, otp: otp);
  }
}
