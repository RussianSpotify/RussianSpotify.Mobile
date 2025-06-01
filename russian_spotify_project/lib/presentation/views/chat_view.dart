import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/chat/chat_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/chat/chat_event.dart';
import 'package:russian_spotify_project/presentation/blocs/chat/chat_state.dart';

class ChatView extends StatefulWidget {
  final String receiverId;
  const ChatView({super.key, required this.receiverId});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Чат с поддержкой")),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                return ListView(
                  children:
                      state.messages.map((msg) {
                        return ListTile(
                          title: Text(msg.username),
                          subtitle: Text(msg.content),
                        );
                      }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _controller)),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    context.read<ChatBloc>().add(
                      SendMessage(widget.receiverId, _controller.text),
                    );
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
