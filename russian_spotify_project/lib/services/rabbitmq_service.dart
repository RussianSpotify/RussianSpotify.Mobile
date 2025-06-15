import 'package:dart_amqp/dart_amqp.dart';

class RabbitMQService {
  late Client _amqpClient;
  late Channel _channel;

  Future<void> initialize() async {
    try {
      final connectionSettings = ConnectionSettings(
        host: 'localhost',
        port: 5672,
      );

      _amqpClient = Client(settings: connectionSettings);
      await _amqpClient.connect();
      _channel = await _amqpClient.channel();
    } catch (e) {
      print('Error initializing RabbitMQ: $e');
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
          final data = message.payloadAsJson;
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