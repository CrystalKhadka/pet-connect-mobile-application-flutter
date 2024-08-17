import 'package:final_assignment/features/favorite/data/model/favorite_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_favorite_dto.g.dart';

@JsonSerializable()
class GetFavoriteDto {
  final bool success;
  final String message;
  final List<FavoriteApiModel> favorites;

  GetFavoriteDto({
    required this.success,
    required this.message,
    required this.favorites,
  });

  factory GetFavoriteDto.fromJson(Map<String, dynamic> json) =>
      _$GetFavoriteDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetFavoriteDtoToJson(this);
}
