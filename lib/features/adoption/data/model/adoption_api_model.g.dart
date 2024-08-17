// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adoption_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdoptionApiModel _$AdoptionApiModelFromJson(Map<String, dynamic> json) =>
    AdoptionApiModel(
      id: json['_id'] as String?,
      pet: json['pet'] == null
          ? null
          : PetApiModel.fromJson(json['pet'] as Map<String, dynamic>),
      formSender: json['formSender'] == null
          ? null
          : AuthApiModel.fromJson(json['formSender'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String?,
      formReceiver: json['formReceiver'] == null
          ? null
          : AuthApiModel.fromJson(json['formReceiver'] as Map<String, dynamic>),
      form: json['form'] == null
          ? null
          : FormApiModel.fromJson(json['form'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdoptionApiModelToJson(AdoptionApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'pet': instance.pet,
      'formSender': instance.formSender,
      'createdAt': instance.createdAt?.toIso8601String(),
      'status': instance.status,
      'formReceiver': instance.formReceiver,
      'form': instance.form,
    };
