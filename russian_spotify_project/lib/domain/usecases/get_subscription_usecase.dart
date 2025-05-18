import 'package:russian_spotify_project/domain/entities/subscription_entity.dart';
import '../../domain/interfaces/subscription_repository.dart';

class GetSubscriptionsUseCase {
  final SubscriptionRepository _subscriptionRepository;

  GetSubscriptionsUseCase(this._subscriptionRepository);

  Future<List<Subscription>> call(String userId) async {
    return await _subscriptionRepository.getSubscriptions(userId);
  }
}
