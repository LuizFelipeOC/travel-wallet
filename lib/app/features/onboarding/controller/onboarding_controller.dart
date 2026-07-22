import 'package:flutter/foundation.dart';

import '../../../core/data/repositories/check_access_repository.dart';
import 'onboarding_state.dart';

class OnboardingController extends ValueNotifier<OnboardingState> {
  final CheckAccessRepository checkAccessRepository;

  OnboardingController({required this.checkAccessRepository}) : super(OnboardingInitial());

  Future<void> checkHasFirstTimeUser() async {
    setState(state: OnboardingLoading());

    final hasFirstTimeUser = await checkAccessRepository.checkHasFirstTimeUser();

    setState(state: OnboardingHasFirstTimeUser(hasFirstTimeUser: hasFirstTimeUser));
  }

  Future<void> setFirstTimeUser() async {
    return await checkAccessRepository.setFirstTimeUser();
  }

  void setState({required OnboardingState state}) {
    value = state;
  }
}
