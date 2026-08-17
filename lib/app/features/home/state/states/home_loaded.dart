import '../../../traveler_planner/traveler_planner_form/data/models/create_form_request.dart';
import 'i_home_state.dart';

class HomeLoaded implements IHomeState {
  final List<CreateFormRequestModel> travels;

  HomeLoaded({required this.travels});

  bool get isEmpty => travels.isEmpty;
}
