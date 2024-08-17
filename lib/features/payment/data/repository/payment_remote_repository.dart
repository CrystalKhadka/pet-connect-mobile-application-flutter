import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/payment/data/data_source/remote/payment_remote_data_source.dart';
import 'package:final_assignment/features/payment/domain/entity/payment_entity.dart';
import 'package:final_assignment/features/payment/domain/repository/i_payment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentRemoteRepositoryProvider = Provider<IPaymentRepository>((ref) {
  return PaymentRemoteRepository(
    paymentRemoteDataSource: ref.read(paymentRemoteDataSourceProvider),
  );
});

class PaymentRemoteRepository implements IPaymentRepository {
  final PaymentRemoteDataSource paymentRemoteDataSource;

  PaymentRemoteRepository({required this.paymentRemoteDataSource});

  @override
  Future<Either<Failure, PaymentEntity>> createPayment(
      PaymentEntity paymentEntity, String? token) {
    return paymentRemoteDataSource.createPayment(paymentEntity, token);
  }

  @override
  Future<Either<Failure, String>> initiateKhaltiPayment(
      PaymentEntity paymentEntity) {
    return paymentRemoteDataSource.initiateKhaltiPayment(paymentEntity);
  }
}
