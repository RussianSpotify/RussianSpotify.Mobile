import 'package:russian_spotify_project/domain/entities/subscription_entity.dart';

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final List<Subscription> subscriptions;
  final int selectedLength;

  SubscriptionLoaded({
    required this.subscriptions,
    required this.selectedLength,
  });
}

class SubscriptionSuccess extends SubscriptionState {}

class SubscriptionFailure extends SubscriptionState {
  final String errorMessage;

  SubscriptionFailure(this.errorMessage);
}
