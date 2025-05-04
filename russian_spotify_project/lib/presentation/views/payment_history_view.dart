// presentation/pages/payment_history_view.dart
import 'package:flutter/material.dart';
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
          appBar: AppBar(title: const Text('Payment History')),
          body:
              viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                    itemCount: viewModel.paymentHistory.length,
                    itemBuilder: (context, index) {
                      final payment = viewModel.paymentHistory[index];
                      return ListTile(
                        title: Text('\$${payment.amount}'),
                        subtitle: Text(payment.date.toString()),
                        trailing: Text(payment.status),
                      );
                    },
                  ),
        );
      },
    );
  }
}
