part of 'conversation_cubit.dart';

@immutable
sealed class ConversationState {}

final class ConversationInitial extends ConversationState {}

final class ConversationLoading extends ConversationState {}

final class ConversationError extends ConversationState {
  final String error;

  ConversationError(this.error);
}

final class ConversationLoaded extends ConversationState {
  final List<Message> messages;

  ConversationLoaded(this.messages);
}
