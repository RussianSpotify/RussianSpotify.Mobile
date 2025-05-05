import '../interfaces/subscription_repository.dart';

class MakeSubscriptionUseCase {
  final SubscriptionRepository repository;

  MakeSubscriptionUseCase(this.repository);

  Future<bool> call(int months) {
    return repository.subscribe(months);
  }
}
