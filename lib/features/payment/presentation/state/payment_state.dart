import 'package:final_assignment/features/payment/domain/entity/payment_entity.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class PaymentState {
  final bool isLoading;
  final String paymentMethod;
  final String? error;
  final PaymentEntity? paymentEntity;
  final PetEntity? petEntity;

  PaymentState(
      {required this.isLoading,
      required this.paymentMethod,
      required this.error,
      required this.paymentEntity,
      required this.petEntity});

  factory PaymentState.initial() {
    return PaymentState(
      isLoading: false,
      paymentMethod: 'cash',
      error: null,
      paymentEntity: null,
      petEntity: null,
    );
  }

  PaymentState copyWith({
    bool? isLoading,
    String? paymentMethod,
    String? error,
    PaymentEntity? paymentEntity,
    PetEntity? petEntity,
  }) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      error: error ?? this.error,
      paymentEntity: paymentEntity ?? this.paymentEntity,
      petEntity: petEntity ?? this.petEntity,
    );
  }
}
