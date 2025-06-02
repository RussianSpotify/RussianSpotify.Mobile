import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/core/di/locator.dart';
import 'package:russian_spotify_project/presentation/blocs/about/about_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/about/about_state.dart';
import 'package:russian_spotify_project/presentation/widgets/about/about_card_widget.dart';
import 'package:russian_spotify_project/presentation/widgets/about/technology_card_widget.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<AboutBloc>(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('О нас'),
          backgroundColor: Colors.purple,
        ),
        body: BlocBuilder<AboutBloc, AboutState>(
          builder: (context, state) {
            if (state is AboutLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AboutLoaded) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildHeader(),
                  const SizedBox(height: 8),
                  _buildDescription(),
                  const SizedBox(height: 24),

                  const Text(
                    'Our team',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children:
                        state.teamMembers
                            .map((member) => AboutCard(member: member))
                            .toList(),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'What we used?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children:
                        state.technologies
                            .map((tech) => TechnologyCard(technology: tech))
                            .toList(),
                  ),
                  const SizedBox(height: 24),

                  const Center(
                    child: Text(
                      '© 2025 Russian Spotify',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              );
            } else if (state is AboutError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'What is this project about?',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Our team, which has developed a project similar to Spotify within the framework of our course "Corporate Development on .NET," is dedicated to innovating in the world of music streaming content. We pay special attention to technological trends and developing skills in .NET programming to offer our users an innovative online music experience. Our project combines technical mastery with an understanding of user needs. We use cutting-edge tools and technologies such as ASP.NET, C#, Entity Framework, and PostgresSQL to create a convenient and functional platform for streaming music, audiobooks, and podcasts. We are confident that our project includes all the necessary features to meet our users demands: from registration and authentication to account management, playlist creation, and personalized recommendations. We strive not only for technical excellence but also for providing a high level of security and user convenience on our platform. Our team takes pride in the ability to deliver a music experience that meets the highest quality standards and satisfies our users needs. We are focused on continually developing and improving our product to remain leaders in the online music and entertainment sphere.',
      style: TextStyle(fontSize: 14, color: Colors.white),
    );
  }
}
