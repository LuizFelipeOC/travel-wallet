import 'package:get_it/get_it.dart';
import 'package:travel_wallet/app/core/database/app_database.dart';
import 'package:travel_wallet/app/core/database/database_crud_helper.dart';
import 'package:travel_wallet/app/features/home/state/home_controller.dart';
import 'package:travel_wallet/app/features/travel_details/data/repositories/expense_repository.dart';
import 'package:travel_wallet/app/features/travel_details/state/travel_details_controller.dart';
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

  getIt.registerLazySingleton<HomeController>(() => HomeController(createFormRepository: getIt()));

  getIt.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepository(databaseCrudHelper: getIt()),
  );

  getIt.registerFactory<TravelDetailsController>(
    () => TravelDetailsController(expenseRepository: getIt()),
  );

  getIt.registerLazySingleton<TravelerPlannerFormController>(
    () => TravelerPlannerFormController(createFormRepository: getIt()),
  );
}
