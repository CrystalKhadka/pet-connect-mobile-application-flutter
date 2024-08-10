// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentApiModel _$PaymentApiModelFromJson(Map<String, dynamic> json) =>
    PaymentApiModel(
      id: json['_id'] as String?,
      pet: PetApiModel.fromJson(json['pet'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : AuthApiModel.fromJson(json['user'] as Map<String, dynamic>),
      paymentMethod: json['paymentMethod'] as String,
      paymentStatus: json['paymentStatus'] as String?,
      paymentAmount: (json['paymentAmount'] as num).toDouble(),
      paymentDate: json['paymentDate'] == null
          ? null
          : DateTime.parse(json['paymentDate'] as String),
    );

Map<String, dynamic> _$PaymentApiModelToJson(PaymentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'pet': instance.pet,
      'user': instance.user,
      'paymentMethod': instance.paymentMethod,
      'paymentStatus': instance.paymentStatus,
      'paymentAmount': instance.paymentAmount,
      'paymentDate': instance.paymentDate?.toIso8601String(),
    };
