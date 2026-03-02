part of 'chats_bloc.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object?> get props => [];
}

class ChatsInitial extends ChatsState {}

class ChatsLoading extends ChatsState {}

class ChatsLoaded extends ChatsState {
  const ChatsLoaded(this.chats);

  final List<ChatEntity> chats;

  @override
  List<Object?> get props => [chats];
}
