import 'package:russian_spotify_project/domain/entities/payment_history_entity.dart';

abstract class PaymentHistoryState {}

class PaymentHistoryInitial extends PaymentHistoryState {}

class PaymentHistoryLoading extends PaymentHistoryState {}

class PaymentHistoryLoaded extends PaymentHistoryState {
  final List<PaymentHistoryEntity> paymentHistory;

  PaymentHistoryLoaded(this.paymentHistory);
}

class PaymentHistoryError extends PaymentHistoryState {
  final String errorMessage;

  PaymentHistoryError(this.errorMessage);
}
