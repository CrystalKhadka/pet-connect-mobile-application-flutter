import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String gender;
  final String date;

  const AuthEntity({
    this.userId,
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.gender,
    required this.date,
  });

  @override
  List<Object?> get props => [
        userId,
        fname,
        lname,
        email,
        password,
        phone,
        address,
        gender,
        date,
      ];
}
