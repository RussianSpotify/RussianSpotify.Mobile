import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/subscription/subscription_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/subscription/subscription_event.dart';
import 'package:russian_spotify_project/presentation/blocs/subscription/subscription_state.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        if (state is SubscriptionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You've successfully subscribed!")),
          );
          Navigator.of(context).pop();
        } else if (state is SubscriptionFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        if (state is SubscriptionInitial) {
          context.read<SubscriptionBloc>().add(LoadSubscriptionOptions());
          return const Center(child: CircularProgressIndicator());
        } else if (state is SubscriptionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SubscriptionLoaded) {
          return Scaffold(
            backgroundColor: Colors.purple.withAlpha(128),
            body: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
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
                              state.subscriptionOptions.map((option) {
                                final isSelected =
                                    option.value == state.selectedLength;
                                return GestureDetector(
                                  onTap: () {
                                    context.read<SubscriptionBloc>().add(
                                      SelectLength(option.value),
                                    );
                                  },
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
                            onPressed: () {
                              context.read<SubscriptionBloc>().add(
                                PerformSubscription(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                            ),
                            child:
                                state is SubscriptionLoading
                                    ? const SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: CircularProgressIndicator(
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
          );
        } else {
          return const Center(
            child: Text('Unknown state', style: TextStyle(color: Colors.white)),
          );
        }
      },
    );
  }
}
