import 'package:final_assignment/features/adoption/data/model/adoption_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_adoptions_by_user_dto.g.dart';

@JsonSerializable()
class GetAdoptionsByUserDto {
  final bool success;
  final String message;
  final int count;
  final List<AdoptionApiModel> adoption;

  GetAdoptionsByUserDto(
      {required this.success,
      required this.message,
      required this.count,
      required this.adoption});

  factory GetAdoptionsByUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetAdoptionsByUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetAdoptionsByUserDtoToJson(this);
}
