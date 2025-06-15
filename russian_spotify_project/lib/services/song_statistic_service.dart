import 'package:http/http.dart' as http;
import 'package:dart_amqp/dart_amqp.dart';

class SongStatisticService {
  final String baseUrl;
  late Client _amqpClient;
  late Channel _channel;

  SongStatisticService({required this.baseUrl});

  Future<void> initialize() async {
    try {
      final connectionSettings = ConnectionSettings(
        host: 'localhost',
        port: 8080,
      );

      _amqpClient = Client(settings: connectionSettings);
      await _amqpClient.connect();
      _channel = await _amqpClient.channel();
    } catch (e) {
      print('Error initializing RabbitMQ: $e');
    }
  }

  Future<int> getSongPlaysNumber(String songId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/Song/GetSongPlaysNumber/$songId'),
    );

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to load plays number');
    }
  }

  Future<void> updateSongPlaysNumber(String songId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Song/UpdateSongPlaysNumber'),
      body: {'songId': songId},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update plays number');
    }
  }

  Future<void> subscribeToPlaysNumberUpdates(String songId, Function(Map<String, dynamic>) onMessage) async {
    try {
      final queue = await _channel.queue('plays_number_updates');
      final consumer = await queue.consume(
        noAck: true,
        consumerTag: 'plays_number_consumer_$songId',
      );

      consumer.listen((message) {
        try {
          final data = message.payloadAsJson as Map<String, dynamic>;
          onMessage(data);
        } catch (e) {
          print('Error processing message: $e');
        }
      });
    } catch (e) {
      print('Error subscribing to plays number updates: $e');
    }
  }

  void close() {
    _amqpClient.close();
  }
} 