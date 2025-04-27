import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/data/models/conversation.dart';
import 'package:test_app/presentation/cubit/inbox_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chats')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: BlocBuilder<InboxCubit, InboxState>(
            builder: (context, state) {
              if (state is InboxLoading || state is InboxLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is InboxError) {
                return Center(child: Text('Error: ${state.error}'));
              } else if (state is InboxLoaded) {
                final inbox = state.conversations;
                return _conversationsContainer(inbox);
              }
              return Center(child: Text('No conversations found.'));
            },
          ),
        ),
      ),
    );
  }

  ListView _conversationsContainer(List<Conversation> inbox) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: inbox.length,
      itemBuilder: (context, index) {
        final conversation = inbox[index];
        return _messageContainer(context: context, conversation: conversation);
      },
    );
  }
}

Widget _messageContainer({
  required BuildContext context,
  required Conversation conversation,
}) {
  return GestureDetector(
    onTap:
        () => context.push(
          '/details/${conversation.id}',
          extra: conversation.topic,
        ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                conversation.topic,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(width: 10),
            if (conversation.modifiedAt != null)
              Text(
                timeago.format(conversation.modifiedAt!),
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
              ),
          ],
        ),
        Text(
          conversation.lastMessage,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
