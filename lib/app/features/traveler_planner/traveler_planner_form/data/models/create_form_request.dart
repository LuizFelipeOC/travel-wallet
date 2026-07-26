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
