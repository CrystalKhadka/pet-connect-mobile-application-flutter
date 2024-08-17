import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_users_dto.g.dart';

@JsonSerializable()
class GetAllUsersDto {
  final bool success;
  final String message;
  final List<AuthApiModel> data;

  GetAllUsersDto({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetAllUsersDto.fromJson(Map<String, dynamic> json) =>
    _$GetAllUsersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllUsersDtoToJson(this);
}
