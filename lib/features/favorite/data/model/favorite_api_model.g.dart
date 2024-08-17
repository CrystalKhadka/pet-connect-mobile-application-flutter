// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteApiModel _$FavoriteApiModelFromJson(Map<String, dynamic> json) =>
    FavoriteApiModel(
      id: json['_id'] as String?,
      pet: json['pet'] == null
          ? null
          : PetApiModel.fromJson(json['pet'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      user: json['user'] == null
          ? null
          : AuthApiModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteApiModelToJson(FavoriteApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'pet': instance.pet,
      'createdAt': instance.createdAt?.toIso8601String(),
      'user': instance.user,
    };
