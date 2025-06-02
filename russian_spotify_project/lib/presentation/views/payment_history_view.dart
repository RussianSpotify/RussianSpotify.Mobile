import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:russian_spotify_project/core/di/locator.dart';
import 'package:russian_spotify_project/presentation/blocs/payment_history/payment_history_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/payment_history/payment_history_event.dart';
import 'package:russian_spotify_project/presentation/blocs/payment_history/payment_history_state.dart';

class PaymentHistoryView extends StatelessWidget {
  const PaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              locator<PaymentHistoryBloc>()
                ..add(LoadPaymentHistory()), // Загружаем данные при старте
      child: Scaffold(
        backgroundColor: Colors.purple.withAlpha(77),
        appBar: AppBar(
          title: const Text('Payment History'),
          backgroundColor: Colors.purple.withAlpha(77),
          foregroundColor: Colors.white,
        ),
        body: BlocConsumer<PaymentHistoryBloc, PaymentHistoryState>(
          listener: (context, state) {
            // Дополнительные действия при изменении состояния (если нужны)
          },
          builder: (context, state) {
            if (state is PaymentHistoryInitial ||
                state is PaymentHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.purple),
              );
            } else if (state is PaymentHistoryLoaded) {
              return ListView.builder(
                itemCount: state.paymentHistory.length,
                itemBuilder: (context, index) {
                  final payment = state.paymentHistory[index];
                  return ListTile(
                    title: Text(
                      '\$${payment.amount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(payment.date),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              );
            } else if (state is PaymentHistoryError) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Unknown state',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
