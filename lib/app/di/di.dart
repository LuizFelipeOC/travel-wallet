import 'package:get_it/get_it.dart';
import 'package:travel_wallet/app/core/database/app_database.dart';
import 'package:travel_wallet/app/core/database/database_crud_helper.dart';
import 'package:travel_wallet/app/features/onboarding/state/onboarding_controller.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/state/traveler_planner_form_controller.dart';

import '../features/onboarding/data/check_access_repository.dart';
import '../core/storage/local_storage.dart';
import '../core/storage/local_storage_interface.dart';
import '../features/traveler_planner/traveler_planner_form/data/repositories/create_form_repository.dart';

GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<AppDatabase>(AppDatabase.new);
  getIt.registerLazySingleton<DatabaseCrudHelper>(() => DatabaseCrudHelper(appDatabase: getIt()));

  getIt.registerLazySingleton<ILocalStorage>(() => Localstorage());

  getIt.registerLazySingleton<CheckAccessRepository>(
    () => CheckAccessRepository(localStorage: getIt()),
  );

  getIt.registerLazySingleton<OnboardingController>(
    () => OnboardingController(checkAccessRepository: getIt()),
  );

  getIt.registerLazySingleton<CreateFormRepository>(
    () => CreateFormRepository(databaseCrudHelper: getIt()),
  );

  getIt.registerFactory<TravelerPlannerFormController>(
    () => TravelerPlannerFormController(createFormRepository: getIt()),
  );
}
