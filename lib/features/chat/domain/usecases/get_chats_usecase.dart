import '../entities/chat_entity.dart';
import '../repositories/chat_repository.dart';

class GetChatsUseCase {
  GetChatsUseCase(this._repository);

  final ChatRepository _repository;

  Future<List<ChatEntity>> call() => _repository.getChats();
}
