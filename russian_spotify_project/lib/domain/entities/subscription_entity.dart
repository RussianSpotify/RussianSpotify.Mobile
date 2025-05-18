import 'package:russian_spotify_project/domain/entities/subscription_status_enum.dart';

class Subscription {
  final String id;
  final DateTime? dateStart;
  final DateTime? dateEnd;
  final SubscriptionStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Subscription({
    required this.id,
    required this.dateStart,
    required this.dateEnd,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      dateStart:
          json['dateStart'] != null ? DateTime.parse(json['dateStart']) : null,
      dateEnd: json['dateEnd'] != null ? DateTime.parse(json['dateEnd']) : null,
      status: SubscriptionStatus.values.firstWhere(
        (e) => e.toString() == 'SubscriptionStatus.${json['status']}',
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
