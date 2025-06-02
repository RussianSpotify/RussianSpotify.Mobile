import 'package:russian_spotify_project/data/dto/get_chat_story_response.dart';

class ChatState {
  final List<GetChatStoryResponseItem> messages;
  final int totalCount;
  final String? error;

  ChatState({this.messages = const [], this.totalCount = 0, this.error});

  ChatState copyWith({
    List<GetChatStoryResponseItem>? messages,
    int? totalCount,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      totalCount: totalCount ?? this.totalCount,
      error: error ?? this.error,
    );
  }
}
