import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class FavoriteEntity extends Equatable {
  const FavoriteEntity({
    this.id,
    required this.pet,
    this.createdAt,
    required this.user,
  });

  final String? id;
  final PetEntity pet;
  final DateTime? createdAt;
  final AuthEntity user;

  @override
  List<Object?> get props => [
        id,
        pet,
        createdAt,
        user,
      ];
}
