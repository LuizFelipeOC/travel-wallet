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

  /// A travel is closed once its last day is over: no expense can be added to
  /// it anymore.
  bool isFinishedAt(DateTime now) {
    final lastMoment = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 999);

    return now.isAfter(lastMoment);
  }

  bool get isFinished => isFinishedAt(DateTime.now());

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
