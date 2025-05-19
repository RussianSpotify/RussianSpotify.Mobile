import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/entities/team_member_entity.dart';
import 'package:russian_spotify_project/domain/entities/technology_entity.dart';
import 'package:russian_spotify_project/presentation/blocs/about/about_event.dart';

import 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutInitial()) {
    on<LoadAboutData>(_loadData);
    on<UpdateAboutData>(_updateData);
  }

  void _loadData(LoadAboutData event, Emitter<AboutState> emit) async {
    emit(AboutLoading());

    try {
      // Имитация загрузки данных
      await Future.delayed(const Duration(seconds: 1));

      final teamMembers = [
        TeamMemberEntity(
          name: 'Damir',
          imageUrl: 'assets/images/team/damir_team.jpg',
          width: 520,
          height: 320,
        ),
        TeamMemberEntity(
          name: 'Vanya',
          imageUrl: 'assets/images/team/vanya_team.jpg',
          width: 520,
          height: 320,
        ),
        TeamMemberEntity(
          name: 'Irek',
          imageUrl: 'assets/images/team/irek_team.jpg',
          width: 520,
          height: 320,
        ),
        TeamMemberEntity(
          name: 'Marat',
          imageUrl: 'assets/images/team/marat_team.jpg',
          width: 520,
          height: 320,
        ),
      ];

      final technologies = [
        TechnologyEntity(
          name: '.NET',
          imageUrl: 'assets/icons/technologies/.net.png',
        ),
        TechnologyEntity(
          name: 'C#',
          imageUrl: 'assets/icons/technologies/cSharp.png',
        ),
        TechnologyEntity(
          name: 'PostgreSQL',
          imageUrl: 'assets/icons/technologies/postgres.png',
        ),
        TechnologyEntity(
          name: 'Redis',
          imageUrl: 'assets/icons/technologies/redis.png',
        ),
        TechnologyEntity(
          name: 'MediatR',
          imageUrl: 'assets/icons/technologies/mediatR.png',
        ),
        TechnologyEntity(
          name: 'gRPC',
          imageUrl: 'assets/icons/technologies/grpc.png',
        ),
        TechnologyEntity(
          name: 'Rabbit MQ',
          imageUrl: 'assets/icons/technologies/rabbitmq.png',
        ),
        TechnologyEntity(
          name: 'GraphQL',
          imageUrl: 'assets/icons/technologies/graphql.png',
        ),
        TechnologyEntity(
          name: 'React TS',
          imageUrl: 'assets/icons/technologies/react.png',
        ),
        TechnologyEntity(
          name: 'Flutter',
          imageUrl: 'assets/icons/technologies/flutter.png',
        ),
        TechnologyEntity(
          name: 'Docker',
          imageUrl: 'assets/icons/technologies/docker.png',
        ),
        TechnologyEntity(
          name: 'K8s',
          imageUrl: 'assets/icons/technologies/k8s.png',
        ),
      ];

      emit(AboutLoaded(teamMembers: teamMembers, technologies: technologies));
    } catch (e) {
      emit(AboutError('Failed to load data: $e'));
    }
  }

  void _updateData(UpdateAboutData event, Emitter<AboutState> emit) {
    // Логика обновления данных, если потребуется
  }
}
