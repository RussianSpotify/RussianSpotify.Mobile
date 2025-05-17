abstract class SubscriptionEvent {}

class LoadSubscriptionOptions extends SubscriptionEvent {}

class SelectLength extends SubscriptionEvent {
  final int length;

  SelectLength(this.length);
}

class PerformSubscription extends SubscriptionEvent {}
