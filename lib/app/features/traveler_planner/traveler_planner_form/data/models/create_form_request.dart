class CreateFormRequestModel {
  final String id;
  final String travelName;
  final String budgetPlan;
  final DateTime startDate;
  final DateTime endDate;

  CreateFormRequestModel({
    required this.id,
    required this.travelName,
    required this.budgetPlan,
    required this.startDate,
    required this.endDate,
  });

  factory CreateFormRequestModel.fromJson(Map<String, Object?> json) {
    return CreateFormRequestModel(
      id: json['id'] as String,
      travelName: json['travel_name'] as String,
      budgetPlan: json['budget_plan'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'travel_name': travelName,
      'budget_plan': budgetPlan,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    };
  }
}
