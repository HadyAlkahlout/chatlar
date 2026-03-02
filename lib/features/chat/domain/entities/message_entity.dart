import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  const MessageEntity({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.sentAt,
    this.isFromMe = false,
    this.status,
  });

  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime sentAt;
  final bool isFromMe;
  final String? status; // sent, delivered, read

  @override
  List<Object?> get props => [id, chatId, senderId, content, sentAt, isFromMe, status];
}
