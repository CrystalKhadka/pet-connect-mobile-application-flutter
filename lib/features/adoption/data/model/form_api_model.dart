import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/adoption/domain/entity/form_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_api_model.g.dart';

@JsonSerializable()
class FormApiModel extends Equatable {
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final double age;
  final String gender;
  final String houseType;
  final String reason;
  final String yard;
  final String petExperience;

  const FormApiModel(
      {required this.fname,
      required this.lname,
      required this.email,
      required this.phone,
      required this.age,
      required this.gender,
      required this.houseType,
      required this.reason,
      required this.yard,
      required this.petExperience});

  const FormApiModel.empty()
      : this(
          fname: '',
          lname: '',
          email: '',
          phone: '',
          age: 0,
          gender: '',
          houseType: '',
          reason: '',
          yard: '',
          petExperience: '',
        );

  FormEntity toEntity() {
    return FormEntity(
      fullName: '$fname $lname',
      email: email,
      phone: phone,
      age: age,
      gender: gender,
      houseType: houseType,
      reason: reason,
      yard: yard,
      petExperience: petExperience,
    );
  }

  factory FormApiModel.fromEntity(FormEntity entity) {
    // destructure the data
    List<String> names = entity.fullName.split(' ');
    String fname = names[0];
    String lname = names[1];

    return FormApiModel(
      fname: fname,
      lname: lname,
      email: entity.email,
      phone: entity.phone,
      age: entity.age,
      gender: entity.gender,
      houseType: entity.houseType,
      reason: entity.reason,
      yard: entity.yard,
      petExperience: entity.petExperience,
    );
  }

  // From json
  factory FormApiModel.fromJson(Map<String, dynamic> json) =>
      _$FormApiModelFromJson(json);

  // To json
  Map<String, dynamic> toJson() => _$FormApiModelToJson(this);
  @override
  List<Object?> get props => [
        fname,
        lname,
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
