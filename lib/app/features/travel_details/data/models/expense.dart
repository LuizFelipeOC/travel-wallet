enum ExpenseCategory { lodging, transport, food, leisure, shopping, other }

class ExpenseModel {
  final String id;
  final String travelId;
  final String description;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;

  ExpenseModel({
    required this.id,
    required this.travelId,
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  factory ExpenseModel.fromJson(Map<String, Object?> json) {
    return ExpenseModel(
      id: json['id'] as String,
      travelId: json['travel_id'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: ExpenseCategory.values.firstWhere(
        (category) => category.name == json['category'],
        orElse: () => ExpenseCategory.other,
      ),
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'travel_id': travelId,
      'description': description,
      'amount': amount,
      'category': category.name,
      'date': date.toIso8601String(),
    };
  }
}
