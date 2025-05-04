class PaymentHistoryEntity {
  final int id;
  final double amount;
  final DateTime date;
  final String status;

  PaymentHistoryEntity({
    required this.id,
    required this.amount,
    required this.date,
    required this.status,
  });
}
