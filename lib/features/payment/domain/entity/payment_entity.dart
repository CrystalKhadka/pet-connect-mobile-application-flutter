import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class PaymentEntity extends Equatable {
  final String? id;
  final PetEntity pet;
  final AuthEntity? user;
  final String paymentMethod;
  final String? paymentStatus;
  final double paymentAmount;
  final DateTime? paymentDate;

  const PaymentEntity(
      {this.id,
      required this.pet,
      this.user,
      required this.paymentMethod,
      this.paymentStatus,
      required this.paymentAmount,
      this.paymentDate});

  @override
  List<Object?> get props =>
      [id, pet, user, paymentMethod, paymentStatus, paymentAmount, paymentDate];
}
