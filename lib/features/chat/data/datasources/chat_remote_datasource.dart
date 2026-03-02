import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/chat_model.dart';

abstract class ChatRemoteDatasource {
  Future<List<ChatModel>> getChats();
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  ChatRemoteDatasourceImpl({required ApiClient apiClient}) : _api = apiClient;

  final ApiClient _api;

  @override
  Future<List<ChatModel>> getChats() async {
    final res = await _api.dio.get<List<dynamic>>(ApiConstants.chats);
    final list = res.data ?? [];
    return list
        .map((e) => ChatModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
