import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/data/models/message.dart';
import 'package:test_app/presentation/cubit/conversation_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;

class ConversationPage extends StatelessWidget {
  final int conversationId;
  final String conversationTopic;
  ConversationPage({
    super.key,
    required this.conversationId,
    required this.conversationTopic,
  });

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: Text(conversationTopic)),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: BlocBuilder<ConversationCubit, ConversationState>(
                      buildWhen: (previous, current) {
                        if (current is ConversationLoading) {
                          return false;
                        }
                        return true;
                      },
                      builder: (context, state) {
                        if (state is ConversationError) {
                          return Center(child: Text('Error: ${state.error}'));
                        } else if (state is ConversationLoaded) {
                          final messages = state.messages;
                          return _messagesList(messages);
                        }
                        return Center(child: Text('No conversations found.'));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Type a message',
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(16),
                              ),
                              controller: _controller,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              final message = _controller.text.trim();
                              if (message.isNotEmpty) {
                                context.read<ConversationCubit>().sendMessage(
                                  message,
                                );
                                _controller.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<ConversationCubit, ConversationState>(
          builder: (context, state) {
            if (state is ConversationLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  ListView _messagesList(List<Message> messages) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return _messageContainer(message);
      },
    );
  }

  Column _messageContainer(Message message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                message.sender,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(width: 10),
            if (message.modifiedAt != null)
              Text(
                timeago.format(message.modifiedAt!),
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
              ),
          ],
        ),
        Text(
          message.message,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
