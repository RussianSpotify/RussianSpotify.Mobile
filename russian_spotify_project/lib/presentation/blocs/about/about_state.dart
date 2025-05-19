import 'package:russian_spotify_project/domain/entities/team_member_entity.dart';
import 'package:russian_spotify_project/domain/entities/technology_entity.dart';

abstract class AboutState {}

class AboutInitial extends AboutState {}

class AboutLoading extends AboutState {}

class AboutLoaded extends AboutState {
  final List<TeamMemberEntity> teamMembers;
  final List<TechnologyEntity> technologies;

  AboutLoaded({required this.teamMembers, required this.technologies});
}

class AboutError extends AboutState {
  final String message;

  AboutError(this.message);
}
