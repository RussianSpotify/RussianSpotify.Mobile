import '../../domain/entities/payment_history_entity.dart';
import '../../domain/interfaces/payment_history_repository.dart';

class PaymentHistoryRepositoryImpl implements PaymentHistoryRepository {
  @override
  Future<List<PaymentHistoryEntity>> getPaymentHistory() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      PaymentHistoryEntity(
        id: 1,
        amount: 100.0,
        date: DateTime.now().subtract(Duration(days: 1)),
      ),
      PaymentHistoryEntity(
        id: 2,
        amount: 50.0,
        date: DateTime.now().subtract(Duration(days: 3)),
      ),
    ];
  }
}
