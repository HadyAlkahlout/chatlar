import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  const ChatEntity({
    required this.id,
    required this.title,
    required this.lastMessageAt,
    this.lastMessagePreview,
    this.avatarUrl,
    this.unreadCount = 0,
  });

  final String id;
  final String title;
  final String? lastMessagePreview;
  final DateTime lastMessageAt;
  final String? avatarUrl;
  final int unreadCount;

  @override
  List<Object?> get props => [id, title, lastMessagePreview, lastMessageAt, avatarUrl, unreadCount];
}
