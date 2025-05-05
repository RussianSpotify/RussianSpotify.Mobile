import '../../domain/entities/subscription_option_entity.dart';
import '../../domain/interfaces/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  @override
  Future<bool> subscribe(int months) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<List<SubscriptionOption>> getSubscriptionOptions() async {
    await Future.delayed(const Duration(seconds: 1));
    var subscriptionOptions = <SubscriptionOption>[
      SubscriptionOption(value: 1, span: "1 month", hint: " - Trial"),
      SubscriptionOption(value: 6, span: "6 months", hint: " - Standard"),
      SubscriptionOption(value: 12, span: "12 months", hint: " - Premium"),
    ];
    return subscriptionOptions;
  }
}
