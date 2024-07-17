import 'package:final_assignment/features/pet/data/model/pet_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_single_pet_dto.g.dart';

@JsonSerializable()
class GetSinglePetDto {
  final bool success;
  final String message;
  final PetApiModel data;

  GetSinglePetDto({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetSinglePetDto.fromJson(Map<String, dynamic> json) =>
      _$GetSinglePetDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetSinglePetDtoToJson(this);
}
