import 'package:get_it/get_it.dart';
import 'package:travel_wallet/app/screens/onboarding/controller/onboarding_controller.dart';

import '../data/repositories/check_access_repository.dart';
import '../infraestructure/infraestructure.dart';

GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ILocalStorage>(() => Localstorage());
  getIt.registerLazySingleton(() => CheckAccessRepository(localStorage: getIt()));
  getIt.registerLazySingleton(() => OnboardingController(checkAccessRepository: getIt()));
}
