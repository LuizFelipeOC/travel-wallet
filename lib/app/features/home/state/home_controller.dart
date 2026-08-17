import 'package:flutter/material.dart';

import '../../../core/result/result.dart';
import '../../traveler_planner/traveler_planner_form/data/erros/traveler_planner_form_erros.dart';
import '../../traveler_planner/traveler_planner_form/data/repositories/create_form_repository.dart';
import 'home_state.dart';

class HomeController extends ValueNotifier<IHomeState> {
  final CreateFormRepository createFormRepository;

  HomeController({required this.createFormRepository}) : super(HomeInitial());

  Future<void> loadTravels() async {
    setState(state: HomeLoading());

    final result = await createFormRepository.getTravels();

    switch (result) {
      case Success(data: final travels):
        setState(state: HomeLoaded(travels: travels));
        return;
      case Failure(error: final error):
        if (error is ITravelerPlannerFormErros) {
          setState(state: HomeError(message: error.message));
          return;
        }

        setState(state: HomeError(message: 'Unexpected error'));
        return;
      default:
        setState(state: HomeError(message: 'Unexpected error'));
        return;
    }
  }

  void setState({required IHomeState state}) {
    value = state;
  }
}
