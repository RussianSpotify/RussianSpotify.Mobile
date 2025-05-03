import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/settings_viewmodel.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Expanded(child: viewModel.selectedPage.component)],
    );
  }
}
