import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/about_viewmodel.dart';
import '../widgets/about/about_card_widget.dart';
import '../widgets/about/technology_card_widget.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AboutViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('О нас'),
          backgroundColor: Colors.purple, // Фиолетовый цвет для AppBar
        ),
        body: Consumer<AboutViewModel>(
          builder: (context, viewModel, _) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Описание компании
                const Text(
                  'What is this project about?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple, // Фиолетовый цвет текста
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Our team, which has developed a project similar to Spotify within the framework of our course "Corporate Development on .NET," is dedicated to innovating in the world of music streaming content. We pay special attention to technological trends and developing skills in .NET programming to offer our users an innovative online music experience. Our project combines technical mastery with an understanding of user needs. We use cutting-edge tools and technologies such as ASP.NET, C#, Entity Framework, and PostgresSQL to create a convenient and functional platform for streaming music, audiobooks, and podcasts. We are confident that our project includes all the necessary features to meet our users demands: from registration and authentication to account management, playlist creation, and personalized recommendations. We strive not only for technical excellence but also for providing a high level of security and user convenience on our platform. Our team takes pride in the ability to deliver a music experience that meets the highest quality standards and satisfies our users needs. We are focused on continually developing and improving our product to remain leaders in the online music and entertainment sphere.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white, // Черный цвет текста для описания
                  ),
                ),
                const SizedBox(height: 24),

                // Команда
                const Text(
                  'Our team',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple, // Фиолетовый цвет текста
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children:
                      viewModel.teamMembers
                          .map((member) => AboutCard(member: member))
                          .toList(),
                ),
                const SizedBox(height: 24),

                // Технологии
                const Text(
                  'What we used?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple, // Фиолетовый цвет текста
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children:
                      viewModel.technologies
                          .map((tech) => TechnologyCard(technology: tech))
                          .toList(),
                ),
                const SizedBox(height: 24),

                // Футер
                const Center(
                  child: Text(
                    '© 2025 Russian Spotify',
                    style: TextStyle(
                      color: Colors.grey, // Серый цвет для футера
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        backgroundColor: Colors.black, // Черный фон для всего экрана
      ),
    );
  }
}
