import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/chat/chat_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/chat/chat_event.dart';
import 'package:russian_spotify_project/presentation/blocs/chat/chat_state.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Чат"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ChatBloc>().add(
                LoadStory(pageNumber: 1, pageSize: 10),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state.error != null) {
                  return Center(child: Text('Ошибка: ${state.error}'));
                }

                return ListView.builder(
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    return ListTile(
                      title: Text(message.sender),
                      subtitle: Text(message.message),
                      trailing: Text('${message.sentDate}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
