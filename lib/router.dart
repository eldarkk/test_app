import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/domain/repository/messages_repository.dart';
import 'package:test_app/injection_container.dart';
import 'package:test_app/presentation/cubit/conversation_cubit.dart';
import 'package:test_app/presentation/cubit/inbox_cubit.dart';
import 'package:test_app/presentation/screens/conversation_page.dart';
import 'package:test_app/presentation/screens/home_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder:
          (context, state) => BlocProvider(
            create:
                (context) =>
                    InboxCubit(sl<MessagesRepository>())..fetchConversations(),
            child: HomePage(),
          ),
    ),
    GoRoute(
      path: '/details/:id',
      builder:
          (context, state) => BlocProvider(
            create:
                (context) => ConversationCubit(
                  messagesRepository: sl<MessagesRepository>(),
                )..fetchMessages(state.pathParameters['id']!),
            child: ConversationPage(
              conversationTopic: state.extra.toString(),
              conversationId: int.parse(state.pathParameters['id']!),
            ),
          ),
    ),
  ],
);
