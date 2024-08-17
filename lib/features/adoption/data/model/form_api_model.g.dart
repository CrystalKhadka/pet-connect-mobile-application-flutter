// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormApiModel _$FormApiModelFromJson(Map<String, dynamic> json) => FormApiModel(
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      age: (json['age'] as num).toDouble(),
      gender: json['gender'] as String,
      houseType: json['houseType'] as String,
      reason: json['reason'] as String,
      yard: json['yard'] as String,
      petExperience: json['petExperience'] as String,
    );

Map<String, dynamic> _$FormApiModelToJson(FormApiModel instance) =>
    <String, dynamic>{
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'phone': instance.phone,
      'age': instance.age,
      'gender': instance.gender,
      'houseType': instance.houseType,
      'reason': instance.reason,
      'yard': instance.yard,
      'petExperience': instance.petExperience,
    };
