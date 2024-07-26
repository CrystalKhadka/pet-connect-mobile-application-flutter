import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

final authApiModelProvider = Provider<AuthApiModel>(
  (ref) => const AuthApiModel.empty(),
);

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? birthDate;
  final String? address;
  final String? gender;
  final String? phone;

  const AuthApiModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.address,
    required this.gender,
    required this.phone,
  });

  const AuthApiModel.empty()
      : this(
          id: '',
          firstName: '',
          lastName: '',
          email: '',
          password: '',
          phone: '',
          address: '',
          birthDate: '',
          gender: '',
        );

  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
      address: address,
      gender: gender,
      birthDate: birthDate,
    );
  }

  factory AuthApiModel.fromEntity(AuthEntity? entity) {
    if (entity == null) {
      return const AuthApiModel.empty();
    }
    return AuthApiModel(
        id: entity.id,
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        password: entity.password,
        birthDate: entity.birthDate,
        address: entity.address,
        gender: entity.gender,
        phone: entity.phone);
  }

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        password,
        birthDate,
        address,
        gender,
        phone,
      ];
}
