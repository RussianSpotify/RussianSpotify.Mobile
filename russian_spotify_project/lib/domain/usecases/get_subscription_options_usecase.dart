import '../entities/subscription_option_entity.dart';
import '../interfaces/subscription_repository.dart';

class GetSubscriptionOptionsUseCase {
  final SubscriptionRepository repository;

  GetSubscriptionOptionsUseCase(this.repository);

  Future<List<SubscriptionOption>> call() async {
    return await repository.getSubscriptionOptions();
  }
}
