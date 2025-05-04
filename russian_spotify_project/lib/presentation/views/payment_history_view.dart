import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:russian_spotify_project/presentation/viewmodels/payment_history_viewmodel.dart';

class PaymentHistoryView extends StatefulWidget {
  const PaymentHistoryView({super.key});

  @override
  State<PaymentHistoryView> createState() => _PaymentHistoryViewState();
}

class _PaymentHistoryViewState extends State<PaymentHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentHistoryViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.paymentHistory.isEmpty && !viewModel.isLoading) {
          viewModel.loadPaymentHistory();
        }

        return Scaffold(
          backgroundColor: Colors.purple.withValues(alpha: 0.3),
          appBar: AppBar(
            title: const Text('Payment History'),
            backgroundColor: Colors.purple.withValues(alpha: 0.3),
            foregroundColor: Colors.white,
          ),
          body:
              viewModel.isLoading
                  ? const Center(
                    child: CircularProgressIndicator(color: Colors.purple),
                  )
                  : ListView.builder(
                    itemCount: viewModel.paymentHistory.length,
                    itemBuilder: (context, index) {
                      final payment = viewModel.paymentHistory[index];
                      return ListTile(
                        title: Text(
                          '\$${payment.amount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat('yyyy-MM-dd HH:mm').format(payment.date),
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
        );
      },
    );
  }
}
