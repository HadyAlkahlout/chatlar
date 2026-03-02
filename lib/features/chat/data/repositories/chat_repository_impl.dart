import 'package:dio/dio.dart';

import '../../domain/entities/chat_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl({required ChatRemoteDatasource remote}) : _remote = remote;

  final ChatRemoteDatasource _remote;

  @override
  Future<List<ChatEntity>> getChats() async {
    try {
      final list = await _remote.getChats();
      return list;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) rethrow;
      return []; // Offline or no API: return empty for demo
    }
  }
}
