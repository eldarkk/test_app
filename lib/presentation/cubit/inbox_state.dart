part of 'inbox_cubit.dart';

@immutable
sealed class InboxState {}

final class InboxInitial extends InboxState {}

final class InboxLoading extends InboxState {}

final class InboxError extends InboxState {
  final String error;

  InboxError(this.error);
}

final class InboxLoaded extends InboxState {
  final List<Conversation> conversations;

  InboxLoaded(this.conversations);
}
