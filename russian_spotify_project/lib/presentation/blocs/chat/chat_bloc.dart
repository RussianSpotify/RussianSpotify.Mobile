import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:russian_spotify_project/generated/chats.pbgrpc.dart';
import 'package:russian_spotify_project/presentation/blocs/chat/chat_event.dart';
import 'package:russian_spotify_project/presentation/blocs/chat/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatServiceClient client;
  final String userId;

  late StreamController<SendMessageStreamRequest> _sendStream;
  late ResponseStream<SendMessageStreamResponse> _receiveStream;
  late StreamSubscription _receiveSub;

  ChatBloc({required this.client, required this.userId}) : super(ChatState()) {
    _sendStream = StreamController<SendMessageStreamRequest>();
    _receiveStream = client.sendMessageStream(_sendStream.stream);

    _receiveSub = _receiveStream.listen((msg) {
      add(ReceiveMessage(msg));
    });

    on<SendMessage>((event, emit) {
      _sendStream.add(
        SendMessageStreamRequest()
          ..receiverId = event.receiverId
          ..content = event.content,
      );
    });

    on<ReceiveMessage>((event, emit) {
      emit(ChatState(messages: List.from(state.messages)..add(event.response)));
    });
  }

  @override
  Future<void> close() {
    _sendStream.close();
    _receiveSub.cancel();
    return super.close();
  }
}
