import 'package:get_it/get_it.dart';
import 'package:travel_wallet/app/features/onboarding/state/onboarding_controller.dart';

import '../features/onboarding/data/check_access_repository.dart';
import '../core/storage/local_storage.dart';
import '../core/storage/local_storage_interface.dart';

GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ILocalStorage>(() => Localstorage());
  getIt.registerLazySingleton(() => CheckAccessRepository(localStorage: getIt()));
  getIt.registerLazySingleton(() => OnboardingController(checkAccessRepository: getIt()));
}
