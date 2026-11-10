import 'package:freezed_annotation/freezed_annotation.dart';
import 'chat_message.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required String title,
    required String model,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<ChatMessage> messages,
    String? systemPrompt,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
