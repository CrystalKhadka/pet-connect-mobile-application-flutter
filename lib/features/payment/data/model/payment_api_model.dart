import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/payment/domain/entity/payment_entity.dart';
import 'package:final_assignment/features/pet/data/model/pet_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_api_model.g.dart';

final paymentApiModelProvider = Provider((ref) => PaymentApiModel.empty());

@JsonSerializable()
class PaymentApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final PetApiModel pet;
  final AuthApiModel? user;
  final String paymentMethod;
  final String? paymentStatus;
  final double paymentAmount;
  final DateTime? paymentDate;

  const PaymentApiModel(
      {required this.id,
      required this.pet,
      required this.user,
      required this.paymentMethod,
      required this.paymentStatus,
      required this.paymentAmount,
      required this.paymentDate});

  // empty
  factory PaymentApiModel.empty() => const PaymentApiModel(
        id: '',
        pet: PetApiModel.empty(),
        user: AuthApiModel.empty(),
        paymentMethod: '',
        paymentStatus: '',
        paymentAmount: 0,
        paymentDate: null,
      );

  factory PaymentApiModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentApiModelToJson(this);

  // to entity
  PaymentEntity toEntity() {
    return PaymentEntity(
      id: id,
      pet: pet.toEntity(),
      user: user?.toEntity(),
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus,
      paymentAmount: paymentAmount,
      paymentDate: paymentDate,
    );
  }

  // from entity
  PaymentApiModel.fromEntity(PaymentEntity entity)
      : id = entity.id,
        pet = PetApiModel.fromEntity(entity.pet),
        user = AuthApiModel.fromEntity(entity.user),
        paymentMethod = entity.paymentMethod,
        paymentStatus = entity.paymentStatus,
        paymentAmount = entity.paymentAmount,
        paymentDate = entity.paymentDate;

  @override
  List<Object?> get props =>
      [id, pet, user, paymentMethod, paymentStatus, paymentAmount, paymentDate];
}
