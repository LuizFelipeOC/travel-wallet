abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {}

class OnboardingHasFirstTimeUser extends OnboardingState {
  final bool hasFirstTimeUser;

  OnboardingHasFirstTimeUser({required this.hasFirstTimeUser});
}
