import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/data/dto/get_all_users_dto.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
    dio: ref.watch(httpServiceProvider),
    authApiModel: ref.watch(authApiModelProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final AuthApiModel authApiModel;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({
    required this.userSharedPrefs,
    required this.dio,
    required this.authApiModel,
  });

  Future<Either<Failure, bool>> registerUser(AuthEntity authEntity) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.registerUser,
        data: AuthApiModel.fromEntity(authEntity).toJson(),
      );
      if (response.statusCode == 201) {
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, bool>> verifyUser() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.get(
        ApiEndpoints.verifyUser,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, bool>> loginUser(
      {required String email, required String password}) async {
    try {
      Response response = await dio.post(ApiEndpoints.loginUser,
          data: {'email': email, 'password': password});

      if (response.statusCode == 201) {
        final token = response.data['token'];
        await userSharedPrefs.setUserToken(token);

        return const Right(true);
      }

      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, AuthEntity>> getMe() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.get(
        ApiEndpoints.getMe,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return Right(AuthApiModel.fromJson(response.data['data']).toEntity());
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, bool>> fingerPrintLogin(String id) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.getToken,
        data: {'id': id},
      );
      if (response.statusCode == 200) {
        final token = response.data['token'];
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, List<AuthEntity>>> getAllUsers() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.get(
        ApiEndpoints.getAllUsers,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final getAllUsersDto = GetAllUsersDto.fromJson(response.data);
        final users = getAllUsersDto.data.map((e) => e.toEntity()).toList();
        return Right(users);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, AuthEntity>> getUser(String id) async {
    try {
      Response response = await dio.get(
        ApiEndpoints.getUserById + id,
      );

      if (response.statusCode == 200) {
        final user = AuthApiModel.fromJson(response.data['data']).toEntity();
        return Right(user);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> googleLogin(
      String token, String? password) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.googleLogin,
        data: {'token': token, 'password': password, 'role': 'adopter'},
      );
      if (response.statusCode == 201) {
        final token = response.data['token'];
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, AuthEntity>> getUserByGoogle(String token) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.getUserByGoogleEmail,
        data: {'token': token},
      );
      if (response.statusCode == 200) {
        final authModel = AuthApiModel.fromJson(response.data['data']);

        return Right(authModel.toEntity());
      }
      if (response.statusCode == 201) {
        const authModel = AuthApiModel.empty();
        return Right(authModel.toEntity());
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
