import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/payment/data/model/payment_api_model.dart';
import 'package:final_assignment/features/payment/domain/entity/payment_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentRemoteDataSourceProvider =
    Provider<PaymentRemoteDataSource>((ref) {
  return PaymentRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  );
});

class PaymentRemoteDataSource {
  final Dio dio;

  PaymentRemoteDataSource({required this.dio});

  Future<Either<Failure, PaymentEntity>> createPayment(
      PaymentEntity paymentEntity, String? token) async {
    try {
      final response = await dio.post(ApiEndpoints.addPayment,
          data: PaymentApiModel.fromEntity(paymentEntity).toJson(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 201) {
        return Right(
            PaymentApiModel.fromJson(response.data['payment']).toEntity());
      } else {
        return Left(Failure(
          error: response.statusMessage.toString(),
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, String>> initiateKhaltiPayment(
      PaymentEntity paymentEntity) async {
    try {
      final response =
          await dio.post(ApiEndpoints.initiateKhaltiPayment, data: {
        'payment': PaymentApiModel.fromEntity(paymentEntity).toJson(),
        'return_url': '',
        'website_url': '',
      });
      if (response.statusCode == 200) {
        return Right(response.data['pidx']);
      } else {
        return Left(Failure(
          error: response.statusMessage.toString(),
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
}
