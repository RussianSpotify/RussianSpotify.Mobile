import '../../domain/entities/payment_history_entity.dart';
import '../../domain/interfaces/payment_history_repository.dart';

class GetPaymentHistoryUseCase {
  final PaymentHistoryRepository _repository;

  GetPaymentHistoryUseCase(this._repository);

  Future<List<PaymentHistoryEntity>> getPaymentHistory() {
    return _repository.getPaymentHistory();
  }
}
