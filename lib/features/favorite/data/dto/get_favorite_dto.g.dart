// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_favorite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFavoriteDto _$GetFavoriteDtoFromJson(Map<String, dynamic> json) =>
    GetFavoriteDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      favorites: (json['favorites'] as List<dynamic>)
          .map((e) => FavoriteApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetFavoriteDtoToJson(GetFavoriteDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'favorites': instance.favorites,
    };
