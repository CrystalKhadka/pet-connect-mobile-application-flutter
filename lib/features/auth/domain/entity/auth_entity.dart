import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? phone;
  final String? address;
  final String? gender;
  final String? birthDate;

  const AuthEntity({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.gender,
    required this.birthDate,
  });

  const AuthEntity.empty()
      : this(
          id: '',
          firstName: '',
          lastName: '',
          email: '',
          password: '',
          phone: '',
          address: '',
          gender: '',
          birthDate: '',
        );

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        password,
        phone,
        address,
        gender,
        birthDate,
      ];
}
