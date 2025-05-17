abstract class SearchEvent {}

class UpdateQuery extends SearchEvent {
  final String query;

  UpdateQuery(this.query);
}
