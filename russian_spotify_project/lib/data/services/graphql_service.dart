import 'package:graphql/client.dart';

class GraphQlService {
  static final HttpLink _httpLink = HttpLink('http://192.168.56.1:56807/graphql');

  static final GraphQLClient _client = GraphQLClient(
    link: _httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );

  Future<Map<String, dynamic>> performQuery({
    required String query,
    Map<String, dynamic>? variables,
  }) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables ?? {},
      );

      final QueryResult result = await _client.query(options);

      if (result.hasException) {
        throw Exception('GraphQL Error: ${result.exception.toString()}');
      }

      return result.data!;
    } catch (e) {
      throw Exception('Failed to perform GraphQL query: $e');
    }
  }
}
