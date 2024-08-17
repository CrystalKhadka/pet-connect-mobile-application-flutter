import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/payment/domain/entity/payment_entity.dart';
import 'package:final_assignment/features/payment/domain/repository/i_payment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentUsecaseProvider = Provider<PaymentUsecase>((ref) {
  return PaymentUsecase(
    ref.read(paymentRepositoryProvider),
    ref.read(userSharedPrefsProvider),
  );
});

class PaymentUsecase {
  final IPaymentRepository repository;
  final UserSharedPrefs userSharedPrefs;

  PaymentUsecase(this.repository, this.userSharedPrefs);

  Future<Either<Failure, PaymentEntity>> createPayment(
      PaymentEntity paymentEntity) async {
    String? token;
    final data = await userSharedPrefs.getUserToken();
    data.fold((l) => null, (r) => token = r);
    return repository.createPayment(paymentEntity, token);
  }

  Future<Either<Failure, String>> initiateKhaltiPayment(
      PaymentEntity paymentEntity) {
    return repository.initiateKhaltiPayment(paymentEntity);
  }
}
