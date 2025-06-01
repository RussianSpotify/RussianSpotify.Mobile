import 'package:russian_spotify_project/generated/chats.pb.dart';

class ChatState {
  final List<SendMessageStreamResponse> messages;

  ChatState({this.messages = const []});
}
