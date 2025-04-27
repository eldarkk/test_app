// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_app/data/models/conversation.dart';
import 'package:test_app/domain/repository/messages_repository.dart';

part 'inbox_state.dart';

class InboxCubit extends Cubit<InboxState> {
  final MessagesRepository messagesRepository;
  InboxCubit(this.messagesRepository) : super(InboxInitial());

  Future<void> fetchConversations() async {
    emit(InboxLoading());
    final result = await messagesRepository.getConversations();
    result.fold(
      (error) => emit(InboxError(error.toString())),
      (conversations) => emit(InboxLoaded(conversations)),
    );
  }
}
