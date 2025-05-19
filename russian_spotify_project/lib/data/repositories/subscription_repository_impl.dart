import 'package:russian_spotify_project/data/services/graphql_service.dart';

import '../../domain/entities/subscription_entity.dart';
import '../../domain/interfaces/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final GraphQlService _graphQlService;

  SubscriptionRepositoryImpl(this._graphQlService);

  @override
  Future<bool> subscribe(int months) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<List<Subscription>> getSubscriptions(String userId) async {
    const String query = r'''
      query GetSubscriptions($userId: ID!) {
        subscriptions(userId: $userId) {
          id
          dateStart
          dateEnd
          status
          createdAt
          updatedAt
        }
      }
    ''';

    final variables = {'userId': userId};

    try {
      final Map<String, dynamic> data = await _graphQlService.performQuery(
        query: query,
        variables: variables,
      );

      final List<dynamic> subscriptionsJson = data['subscriptions'];
      if (subscriptionsJson.isEmpty) {
        return [];
      }

      return subscriptionsJson
          .map((json) => Subscription.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load subscriptions: $e');
    }
  }
}
