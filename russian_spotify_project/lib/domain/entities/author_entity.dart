class Author {
  final String id;
  final String userName;

  Author({required this.id, required this.userName});

  /// Создание объекта из JSON
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'], userName: json['userName']);
  }

  /// Преобразование объекта в JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'userName': userName};
  }
}
