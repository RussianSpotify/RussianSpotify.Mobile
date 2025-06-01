import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:russian_spotify_project/generated/chats.pbgrpc.dart';

class ChatClient {
  late ChatServiceClient _stub;
  late ClientChannel _channel;

  final StreamController<SendMessageStreamRequest> _requestController =
      StreamController();

  ChatClient() {
    _channel = ClientChannel(
      'localhost',
      port: 88,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    _stub = ChatServiceClient(_channel);
  }

  Stream<SendMessageStreamResponse> connect() {
    return _stub.sendMessageStream(_requestController.stream);
  }

  void sendMessage(String receiverId, String content) {
    _requestController.add(
      SendMessageStreamRequest()
        ..receiverId = receiverId
        ..content = content,
    );
  }

  void dispose() async {
    await _requestController.close();
    await _channel.shutdown();
  }
}
