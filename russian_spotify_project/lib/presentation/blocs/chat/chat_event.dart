import 'package:russian_spotify_project/generated/chats.pb.dart';

abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  final String receiverId;
  final String content;

  SendMessage(this.receiverId, this.content);
}

class ReceiveMessage extends ChatEvent {
  final SendMessageStreamResponse response;

  ReceiveMessage(this.response);
}

class LoadStory extends ChatEvent {
  final int pageNumber;
  final int pageSize;

  LoadStory({required this.pageNumber, required this.pageSize});
}
