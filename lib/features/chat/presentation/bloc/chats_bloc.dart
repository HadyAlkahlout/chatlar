import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/chat_entity.dart';
import '../../domain/usecases/get_chats_usecase.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc(this._getChats) : super(ChatsInitial()) {
    on<ChatsLoadRequested>(_onLoad);
  }

  final GetChatsUseCase _getChats;

  Future<void> _onLoad(ChatsLoadRequested event, Emitter<ChatsState> emit) async {
    emit(ChatsLoading());
    try {
      final list = await _getChats();
      emit(ChatsLoaded(list));
    } catch (_) {
      emit(ChatsLoaded([]));
    }
  }
}
