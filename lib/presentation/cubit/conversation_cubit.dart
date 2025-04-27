// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:meta/meta.dart';
import 'package:test_app/data/models/message.dart';
import 'package:test_app/domain/repository/messages_repository.dart';

part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  final MessagesRepository messagesRepository;
  ConversationCubit({required this.messagesRepository})
    : super(ConversationInitial());

  List<Message> _messages = [];

  Future<void> fetchMessages(String conversationId) async {
    emit(ConversationLoading());
    final result = await messagesRepository.getMessages(conversationId);
    result.fold((error) => emit(ConversationError(error.toString())), (
      messages,
    ) {
      _messages = messages;
      emit(ConversationLoaded(_messages));
    });
  }

  sendMessage(String message) async {
    emit(ConversationLoading());
    final text = lorem(paragraphs: 1, words: message.length + 1);
    await Future.delayed(const Duration(seconds: 2));
    final newMessage = Message(
      id: Random().nextInt(10000).toString(),
      message: text,
      sender: 'Me',
      modifiedAt: DateTime.now(),
    );
    _messages.add(newMessage);
    emit(ConversationLoaded(_messages));
  }
}
