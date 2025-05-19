import 'package:russian_spotify_project/domain/entities/subscription_entity.dart';

abstract class SubscriptionRepository {
  Future<bool> subscribe(int months);
  Future<List<Subscription>> getSubscriptions(String userId);
}
