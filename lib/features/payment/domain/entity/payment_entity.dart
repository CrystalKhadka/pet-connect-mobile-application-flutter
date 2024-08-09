import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class PaymentEntity extends Equatable {
  final String id;
  final PetEntity pet;
  final AuthEntity user;
  final String paymentMethod;
  final String paymentStatus;
  final String paymentAmount;
  final String paymentDate;

  const PaymentEntity(
      {required this.id,
      required this.pet,
      required this.user,
      required this.paymentMethod,
      required this.paymentStatus,
      required this.paymentAmount,
      required this.paymentDate});

  @override
  List<Object?> get props =>
      [id, pet, user, paymentMethod, paymentStatus, paymentAmount, paymentDate];
}
