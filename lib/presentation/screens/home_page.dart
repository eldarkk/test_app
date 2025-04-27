import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/presentation/cubit/inbox_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chats')),
      body: BlocBuilder<InboxCubit, InboxState>(
        builder: (context, state) {
          if (state is InboxLoading || state is InboxLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is InboxError) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is InboxLoaded) {
            final inbox = state.conversations;
            return ListView.builder(
              itemCount: inbox.length,
              itemBuilder: (context, index) {
                final conversation = inbox[index];
                return ListTile(
                  title: Text(conversation.topic),
                  onTap:
                      () => context.push(
                        '/details/${conversation.id}',
                        extra: conversation.topic,
                      ),
                );
              },
            );
          }
          return Center(child: Text('No conversations found.'));
        },
      ),
    );
  }
}
