import 'package:flutter/material.dart';
import '../../domain/entities/payment_history_entity.dart';
import '../../domain/usecases/get_payment_history_usecase.dart';

class PaymentHistoryViewModel extends ChangeNotifier {
  final GetPaymentHistoryUseCase _paymentHistoryUseCase;

  PaymentHistoryViewModel(this._paymentHistoryUseCase);

  List<PaymentHistoryEntity> _paymentHistory = [];
  bool _isLoading = false;

  List<PaymentHistoryEntity> get paymentHistory => _paymentHistory;
  bool get isLoading => _isLoading;

  Future<void> loadPaymentHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      _paymentHistory = await _paymentHistoryUseCase.getPaymentHistory();
    } catch (e) {
      _paymentHistory = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
