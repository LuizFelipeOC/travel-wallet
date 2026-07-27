abstract interface class ITravelerPlannerFormState {}

class TravelerPlannerFormInitial implements ITravelerPlannerFormState {}

class TravelerPlannerFormLoading implements ITravelerPlannerFormState {}

class TravelerPlannerFormError implements ITravelerPlannerFormState {
  final String message;

  TravelerPlannerFormError({required this.message});
}

class TravelerPlannerFormSuccess implements ITravelerPlannerFormState {}
