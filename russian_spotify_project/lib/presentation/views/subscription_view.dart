import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/subscription_viewmodel.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = Provider.of<SubscriptionViewModel>(
      context,
      listen: false,
    );
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionViewModel>(
      builder:
          (context, viewModel, _) => Scaffold(
            backgroundColor: Colors.purple.withValues(alpha: 0.5),
            body: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Subscription",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 8),
                        const Text(
                          "Choose subscription length:",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children:
                              viewModel.subscriptionOptions.map((option) {
                                final isSelected =
                                    option.value == viewModel.selectedLength;
                                return GestureDetector(
                                  onTap:
                                      () => viewModel.setLength(option.value),
                                  child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? Colors.grey[700]
                                              : Colors.grey[300],
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? Colors.grey[400]!
                                                : Colors.transparent,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${option.span}${option.hint}',
                                      style: TextStyle(
                                        color:
                                            isSelected
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Subscribe to our music service and get access to the best songs ever!",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                viewModel.isLoading
                                    ? null
                                    : () => viewModel.subscribe(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                            ),
                            child:
                                viewModel.isLoading
                                    ? SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: const CircularProgressIndicator(
                                        color: Colors.purple,
                                      ),
                                    )
                                    : const Text("Subscribe"),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Close"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
