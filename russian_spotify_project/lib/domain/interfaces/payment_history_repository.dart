import '../../domain/entities/payment_history_entity.dart';

abstract class PaymentHistoryRepository {
  Future<List<PaymentHistoryEntity>> getPaymentHistory();
}
