import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/adoption/domain/entity/form_entity.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class AdoptionEntity extends Equatable {
  final String? id;
  final PetEntity? pet;
  final AuthEntity? formSender;
  final DateTime? createdAt;
  final String? status;
  final AuthEntity? formReceiver;
  final FormEntity? form;

  const AdoptionEntity(
      {this.id,
      required this.pet,
      this.formSender,
      this.createdAt,
      this.status,
      required this.formReceiver,
      required this.form});

  @override
  List<Object?> get props =>
      [id, pet, formSender, createdAt, status, formReceiver, form];
}
