import 'package:get_it/get_it.dart';
import 'package:travel_wallet/app/features/onboarding/state/onboarding_controller.dart';

import '../features/onboarding/data/check_access_repository.dart';
import '../core/storage/local_storage.dart';
import '../core/storage/local_storage_interface.dart';
import '../features/traveler_planner/traveler_planner_form/data/repositories/create_form_repository.dart';

GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ILocalStorage>(() => Localstorage());

  getIt.registerLazySingleton<CheckAccessRepository>(
    () => CheckAccessRepository(localStorage: getIt()),
  );

  getIt.registerLazySingleton<OnboardingController>(
    () => OnboardingController(checkAccessRepository: getIt()),
  );

  getIt.registerFactory<CreateFormRepository>(() => CreateFormRepository());
}
