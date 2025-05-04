import 'package:flutter/material.dart';
import 'package:russian_spotify_project/domain/usecases/get_subscription_options_usecase.dart';
import '../../domain/entities/subscription_option_entity.dart';

import '../../domain/usecases/make_subscription_usecase.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final GetSubscriptionOptionsUseCase _getSubscriptionOptionsUseCase;
  final MakeSubscriptionUseCase _makeSubscriptionUseCase;

  int selectedLength = 1;
  bool isLoading = false;

  List<SubscriptionOption> _subscriptionOptions = [];
  List<SubscriptionOption> get subscriptionOptions => _subscriptionOptions;

  SubscriptionViewModel(
    this._getSubscriptionOptionsUseCase,
    this._makeSubscriptionUseCase,
  );

  Future<void> init() async {
    try {
      isLoading = true;
      notifyListeners();

      _subscriptionOptions = await _getSubscriptionOptionsUseCase.call();
    } catch (e) {
      _subscriptionOptions = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setLength(int value) {
    selectedLength = value;
    notifyListeners();
  }

  Future<void> subscribe(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final success = await _makeSubscriptionUseCase(selectedLength);

    isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You've successfully subscribed!")),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong. Please try again."),
        ),
      );
    }
  }
}
