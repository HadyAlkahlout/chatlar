import '../../domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.id,
    required super.title,
    required super.lastMessageAt,
    super.lastMessagePreview,
    super.avatarUrl,
    super.unreadCount,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String,
      title: json['title'] as String,
      lastMessageAt: DateTime.parse(json['last_message_at'] as String),
      lastMessagePreview: json['last_message_preview'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      unreadCount: json['unread_count'] as int? ?? 0,
    );
  }
}
