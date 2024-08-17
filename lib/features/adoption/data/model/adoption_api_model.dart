import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/adoption/data/model/form_api_model.dart';
import 'package:final_assignment/features/adoption/domain/entity/adoption_entity.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/pet/data/model/pet_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'adoption_api_model.g.dart';

final adoptionApiModelProvider = Provider<AdoptionApiModel>(
  (ref) => AdoptionApiModel.empty(),
);

@JsonSerializable()
class AdoptionApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final PetApiModel? pet;
  final AuthApiModel? formSender;
  final DateTime? createdAt;
  final String? status;
  final AuthApiModel? formReceiver;
  final FormApiModel? form;

  const AdoptionApiModel(
      {required this.id,
      required this.pet,
      required this.formSender,
      required this.createdAt,
      required this.status,
      required this.formReceiver,
      required this.form});

  AdoptionEntity toEntity() {
    return AdoptionEntity(
      id: id,
      pet: pet?.toEntity(),
      formSender: formSender?.toEntity(),
      createdAt: createdAt,
      status: status,
      formReceiver: formReceiver?.toEntity(),
      form: form?.toEntity(),
    );
  }

  AdoptionApiModel.empty()
      : this(
          id: '',
          pet: const PetApiModel.empty(),
          formSender: const AuthApiModel.empty(),
          createdAt: DateTime.now(),
          status: '',
          formReceiver: const AuthApiModel.empty(),
          form: const FormApiModel.empty(),
        );

  factory AdoptionApiModel.fromEntity(AdoptionEntity entity) {
    print(entity);
    return AdoptionApiModel(
      id: entity.id,
      pet: entity.pet != null ? PetApiModel.fromEntity(entity.pet!) : null,
      formSender: entity.formSender != null
          ? AuthApiModel.fromEntity(entity.formSender!)
          : null,
      createdAt: entity.createdAt,
      status: entity.status,
      formReceiver: entity.formReceiver != null
          ? AuthApiModel.fromEntity(entity.formReceiver!)
          : null,
      form: entity.form != null ? FormApiModel.fromEntity(entity.form!) : null,
    );
  }

  // From json
  factory AdoptionApiModel.fromJson(Map<String, dynamic> json) =>
      _$AdoptionApiModelFromJson(json);

  // To json
  Map<String, dynamic> toJson() => _$AdoptionApiModelToJson(this);

  @override
  List<Object?> get props =>
      [id, pet, formSender, createdAt, status, formReceiver, form];
}
