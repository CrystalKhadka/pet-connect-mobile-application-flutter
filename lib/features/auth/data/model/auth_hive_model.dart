import 'package:final_assignment/app/constants/hive_table_constant.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider((ref) => AuthHiveModel.empty());

@HiveType(typeId: HiveTableConstant.userBoxId)
class AuthHiveModel {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String? fname;
  @HiveField(2)
  final String? lname;
  @HiveField(3)
  final String? email;
  @HiveField(4)
  final String? password;
  @HiveField(5)
  final String? phone;
  @HiveField(6)
  final String? address;
  @HiveField(7)
  final String? date;
  @HiveField(8)
  final String? gender;

  AuthHiveModel(
      {String? userId,
      required this.fname,
      required this.lname,
      required this.email,
      required this.password,
      required this.phone,
      required this.address,
      required this.date,
      required this.gender})
      : userId = userId ?? const Uuid().v4();

  AuthHiveModel.empty()
      : this(
            userId: '',
            fname: '',
            lname: '',
            email: '',
            password: '',
            phone: '',
            address: '',
            date: '',
            gender: '');

  AuthEntity toEntity() => AuthEntity(
      id: userId,
      firstName: fname,
      lastName: lname,
      email: email,
      password: password,
      phone: phone,
      address: address,
      gender: gender,
      birthDate: date);

  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: const Uuid().v4(),
      fname: entity.firstName,
      lname: entity.lastName,
      email: entity.email,
      password: entity.password,
      phone: entity.phone,
      address: entity.address,
      date: entity.birthDate,
      gender: entity.gender,
    );
  }

  List<AuthEntity> toEntities(List<AuthHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  List<AuthHiveModel> fromEntities(List<AuthEntity> entities) =>
      entities.map((entity) => AuthHiveModel.fromEntity(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId, fname: $fname, lname: $lname, email: $email, password: $password, phone: $phone, address: $address, date: $date';
  }
}
