import 'package:equatable/equatable.dart';

class FormEntity extends Equatable {
  final String fullName;

  final String email;
  final String phone;
  final double age;
  final String gender;
  final String houseType;
  final String reason;
  final String yard;
  final String petExperience;

  const FormEntity(
      {required this.fullName,
 
      required this.email,
      required this.phone,
      required this.age,
      required this.gender,
      required this.houseType,
      required this.reason,
      required this.yard,
      required this.petExperience});

  @override
  List<Object?> get props => [
        
        fullName,
        email,
        phone,
        age,
        gender,
        houseType,
        reason,
        yard,
        petExperience,
      ];
}
