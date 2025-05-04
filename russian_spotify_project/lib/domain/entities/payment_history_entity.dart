class PaymentHistoryEntity {
  final int id;
  final double amount;
  final DateTime date;

  PaymentHistoryEntity({
    required this.id,
    required this.amount,
    required this.date,
  });
}
