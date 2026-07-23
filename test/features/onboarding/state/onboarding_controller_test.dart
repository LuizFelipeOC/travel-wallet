import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travel_wallet/app/features/onboarding/data/check_access_repository.dart';
import 'package:travel_wallet/app/features/onboarding/state/onboarding_controller.dart';
import 'package:travel_wallet/app/features/onboarding/state/onboarding_state.dart';

class MockCheckAccessRepository extends Mock implements CheckAccessRepository {}

void main() {
  group('OnboardingController', () {
    late MockCheckAccessRepository repository;

    setUp(() {
      repository = MockCheckAccessRepository();
    });

    test('starts on initial state', () {
      final controller = OnboardingController(checkAccessRepository: repository);

      expect(controller.value, isA<OnboardingInitial>());
    });

    test('emits loading and then has first time user state', () async {
      when(() => repository.checkHasFirstTimeUser()).thenAnswer((_) async => true);
      final controller = OnboardingController(checkAccessRepository: repository);
      final states = <OnboardingState>[];

      controller.addListener(() {
        states.add(controller.value);
      });

      await controller.checkHasFirstTimeUser();

      expect(states, hasLength(2));
      expect(states[0], isA<OnboardingLoading>());
      expect(states[1], isA<OnboardingHasFirstTimeUser>());
      expect((states[1] as OnboardingHasFirstTimeUser).hasFirstTimeUser, isTrue);
      verify(() => repository.checkHasFirstTimeUser()).called(1);
      verifyNever(() => repository.setFirstTimeUser());
    });

    test('delegates setFirstTimeUser to repository', () async {
      when(() => repository.setFirstTimeUser()).thenAnswer((_) async {});
      final controller = OnboardingController(checkAccessRepository: repository);

      await controller.setFirstTimeUser();

      verify(() => repository.setFirstTimeUser()).called(1);
      verifyNever(() => repository.checkHasFirstTimeUser());
    });
  });
}
