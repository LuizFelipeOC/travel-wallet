import '../../traveler_planner/traveler_planner_form/data/models/create_form_request.dart';

abstract interface class IHomeState {}

class HomeInitial implements IHomeState {}

class HomeLoading implements IHomeState {}

class HomeError implements IHomeState {
  final String message;

  HomeError({required this.message});
}

class HomeLoaded implements IHomeState {
  final List<CreateFormRequestModel> travels;

  HomeLoaded({required this.travels});

  bool get isEmpty => travels.isEmpty;
}
