import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/favorite/domain/entity/favorite_entity.dart';
import 'package:final_assignment/features/pet/data/model/pet_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_api_model.g.dart';

final favoriteApiModelProvider = Provider<FavoriteApiModel>(
  (ref) => FavoriteApiModel.empty(),
);

@JsonSerializable()
class FavoriteApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final PetApiModel? pet;
  final DateTime? createdAt;
  final AuthApiModel? user;

  const FavoriteApiModel({
    required this.id,
    required this.pet,
    required this.createdAt,
    required this.user,
  });

  FavoriteApiModel.empty()
      : this(
          id: '',
          pet: const PetApiModel.empty(),
          createdAt: DateTime.now(),
          user: const AuthApiModel.empty(),
        );

  factory FavoriteApiModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteApiModelToJson(this);

  FavoriteEntity toEntity() {
    return FavoriteEntity(
      id: id,
      pet: pet!.toEntity(),
      createdAt: createdAt,
      user: user!.toEntity(),
    );
  }

  factory FavoriteApiModel.fromEntity(FavoriteEntity entity) {
    return FavoriteApiModel(
      id: entity.id,
      pet: PetApiModel.fromEntity(entity.pet),
      createdAt: entity.createdAt,
      user: AuthApiModel.fromEntity(entity.user),
    );
  }

  List<FavoriteEntity> toEntities(List<FavoriteApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  factory FavoriteApiModel.fromEntities(List<FavoriteEntity> entities) {
    return FavoriteApiModel(
      id: entities[0].id,
      pet: PetApiModel.fromEntity(entities[0].pet),
      createdAt: entities[0].createdAt,
      user: AuthApiModel.fromEntity(entities[0].user),
    );
  }

  @override
  List<Object?> get props => [
        id,
        pet,
        createdAt,
        user,
      ];
}
