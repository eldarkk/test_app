import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:test_app/data/models/conversation.dart';
import 'package:test_app/data/models/message.dart';

abstract class MessagesDataSource {
  Future<List<Conversation>> getConversations();

  Future<List<Message>> getMessages(String conversationId);
}

class MessagesRemoteDataSource implements MessagesDataSource {
  final Dio dio;
  MessagesRemoteDataSource(this.dio);

  @override
  Future<List<Conversation>> getConversations() async {
    try {
      final response = await dio.get(
        'https://media.jefe-stg.idtm.io/programming-test/api/inbox.json',
      );
      return (response.data as List)
          .map((e) => Conversation.fromJson(e))
          .toList();
    } on DioException catch (e) {
      log(e.toString());
      throw Exception('Failed to load conversations: ${e.message}');
    } on Exception catch (e) {
      log(e.toString());
      throw Exception('Failed to load conversations: ${e.toString()}');
    }
  }

  @override
  Future<List<Message>> getMessages(String conversationId) async {
    try {
      final response = await dio.get('$conversationId.json');
      return (response.data as List).map((e) => Message.fromJson(e)).toList();
    } on DioException catch (e) {
      log(e.toString());
      throw Exception('Failed to load messages: ${e.message}');
    } on Exception catch (e) {
      log(e.toString());
      throw Exception('Failed to load messages: ${e.toString()}');
    }
  }
}

String cleanJson(String input) {
  return input.replaceAllMapped(
    RegExp(r',(\s*[\]}])'),
    (match) => match.group(1)!,
  );
}
