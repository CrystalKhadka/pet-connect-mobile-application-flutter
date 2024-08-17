import 'package:final_assignment/features/chat/data/model/message_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_messages_dto.g.dart';

@JsonSerializable()
class GetAllMessagesDto {
  final String? message;
  final bool? success;
  final List<MessageApiModel>? messages;

  GetAllMessagesDto({
    required this.message,
    required this.success,
    required this.messages,
  });

  factory GetAllMessagesDto.fromJson(Map<String, dynamic> json) =>
      _$GetAllMessagesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllMessagesDtoToJson(this);
}
