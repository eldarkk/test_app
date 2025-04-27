import 'package:dartz/dartz.dart';
import 'package:test_app/data/datasource/messages_remote_data_source.dart';
import 'package:test_app/data/models/conversation.dart';
import 'package:test_app/data/models/message.dart';

abstract class MessagesRepository {
  Future<Either<Exception, List<Conversation>>> getConversations();

  Future<Either<Exception, List<Message>>> getMessages(String conversationId);
}

class MessagesRepositoryImpl implements MessagesRepository {
  final MessagesDataSource messagesDataSource;

  MessagesRepositoryImpl(this.messagesDataSource);

  @override
  Future<Either<Exception, List<Conversation>>> getConversations() async {
    try {
      final conversations = await messagesDataSource.getConversations();
      return Right(conversations);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<Message>>> getMessages(
    String conversationId,
  ) async {
    try {
      final messages = await messagesDataSource.getMessages(conversationId);
      return Right(messages);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
