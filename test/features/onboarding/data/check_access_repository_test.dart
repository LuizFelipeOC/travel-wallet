import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travel_wallet/app/core/storage/local_storage_interface.dart';
import 'package:travel_wallet/app/features/onboarding/data/check_access_repository.dart';

class MockLocalStorage extends Mock implements ILocalStorage<dynamic> {}

void main() {
  group('CheckAccessRepository', () {
    late MockLocalStorage storage;
    late CheckAccessRepository repository;

    setUp(() {
      storage = MockLocalStorage();
      repository = CheckAccessRepository(localStorage: storage);
    });

    test('returns true when local storage has first time access set to true', () async {
      when(
        () => storage.get(key: 'is_first_time_user'),
      ).thenAnswer((_) async => LocalStorageSuccess<bool>(data: true));

      final result = await repository.checkHasFirstTimeUser();

      expect(result, isTrue);
      verify(() => storage.get(key: 'is_first_time_user')).called(1);
    });

    test('returns false when local storage value is missing or false', () async {
      when(
        () => storage.get(key: 'is_first_time_user'),
      ).thenAnswer((_) async => LocalStorageSuccess<dynamic>(data: null));

      final result = await repository.checkHasFirstTimeUser();

      expect(result, isFalse);
      verify(() => storage.get(key: 'is_first_time_user')).called(1);
    });

    test('throws when local storage fails while checking access', () async {
      when(
        () => storage.get(key: 'is_first_time_user'),
      ).thenAnswer((_) async => LocalStorageFailure(message: 'boom'));

      expect(
        () => repository.checkHasFirstTimeUser(),
        throwsA(
          isA<Exception>().having(
            (exception) => exception.toString(),
            'message',
            contains('Failed to retrieve access: boom'),
          ),
        ),
      );

      verify(() => storage.get(key: 'is_first_time_user')).called(1);
    });

    test('writes first time access flag as true', () async {
      when(
        () => storage.set(key: 'is_first_time_user', value: true),
      ).thenAnswer((_) async => LocalStorageSuccess<dynamic>(data: true));

      await repository.setFirstTimeUser();

      verify(() => storage.set(key: 'is_first_time_user', value: true)).called(1);
    });

    test('throws when local storage fails while writing access', () async {
      when(
        () => storage.set(key: 'is_first_time_user', value: true),
      ).thenAnswer((_) async => LocalStorageFailure(message: 'boom'));

      expect(
        () => repository.setFirstTimeUser(),
        throwsA(
          isA<Exception>().having(
            (exception) => exception.toString(),
            'message',
            contains('Failed to set access: boom'),
          ),
        ),
      );

      verify(() => storage.set(key: 'is_first_time_user', value: true)).called(1);
    });
  });
}
