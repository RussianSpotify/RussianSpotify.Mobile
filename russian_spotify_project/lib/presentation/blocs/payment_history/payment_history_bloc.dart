import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/usecases/get_payment_history_usecase.dart';
import 'package:russian_spotify_project/presentation/blocs/payment_history/payment_history_event.dart';
import 'payment_history_state.dart';

class PaymentHistoryBloc
    extends Bloc<PaymentHistoryEvent, PaymentHistoryState> {
  final GetPaymentHistoryUseCase _paymentHistoryUseCase;

  PaymentHistoryBloc(this._paymentHistoryUseCase)
    : super(PaymentHistoryInitial()) {
    on<LoadPaymentHistory>(_loadPaymentHistory);
  }

  Future<void> _loadPaymentHistory(
    LoadPaymentHistory event,
    Emitter<PaymentHistoryState> emit,
  ) async {
    emit(PaymentHistoryLoading());

    try {
      final paymentHistory = await _paymentHistoryUseCase.getPaymentHistory();
      emit(PaymentHistoryLoaded(paymentHistory));
    } catch (e) {
      emit(PaymentHistoryError('Failed to load payment history: $e'));
    }
  }
}
