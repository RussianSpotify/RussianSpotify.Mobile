import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:http/http.dart' as http;
import 'package:russian_spotify_project/data/dto/get_chat_story_request.dart';
import 'package:russian_spotify_project/data/dto/get_chat_story_response.dart';
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
    // Инициализация потоков для отправки и получения сообщений
    _sendStream = StreamController<SendMessageStreamRequest>();
    _receiveStream = client.sendMessageStream(_sendStream.stream);

    // Подписываемся на входящие сообщения
    _receiveSub = _receiveStream.listen((msg) {
      add(ReceiveMessage(msg));
    });

    // Обработка отправки сообщений
    on<SendMessage>((event, emit) {
      _sendStream.add(
        SendMessageStreamRequest()
          ..receiverId = event.receiverId
          ..content = event.content,
      );
    });

    GetChatStoryResponseItem mapToChatStoryItem(
      SendMessageStreamResponse response,
    ) {
      return GetChatStoryResponseItem(
        id: response.senderId, // Используем senderId как id
        message: response.content, // Текст сообщения
        sender: response.username, // Имя отправителя
        senderId: response.senderId, // ID отправителя
        senderImageId: null, // Если изображения нет, используем null
        sentDate: DateTime.now(), // Текущая дата отправки
      );
    }

    // Обработка получения новых сообщений
    on<ReceiveMessage>((event, emit) {
      final chatStoryItem = mapToChatStoryItem(event.response);
      emit(
        state.copyWith(messages: List.from(state.messages)..add(chatStoryItem)),
      );
    });

    // Загрузка истории чата
    on<LoadStory>((event, emit) async {
      try {
        // Формируем запрос на получение истории чата
        final request = GetChatStoryRequest(
          pageNumber: event.pageNumber,
          pageSize: event.pageSize,
        );

        // Отправляем POST-запрос на сервер
        final response = await http.post(
          Uri.parse('http://192.168.0.174:87/chat/grpc'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(request.toJson()),
        );

        if (response.statusCode == 200) {
          // Парсим ответ от сервера
          final data = json.decode(response.body);
          final getStoryResponse = GetChatStoryResponse.fromJson(data);

          // Обновляем состояние
          emit(
            state.copyWith(
              messages: List.from(state.messages)
                ..addAll(getStoryResponse.entities),
              totalCount: getStoryResponse.totalCount,
            ),
          );
        } else {
          throw Exception('Failed to load story');
        }
      } catch (e) {
        emit(state.copyWith(error: e.toString()));
      }
    });
  }

  @override
  Future<void> close() {
    _sendStream.close();
    _receiveSub.cancel();
    return super.close();
  }
}
