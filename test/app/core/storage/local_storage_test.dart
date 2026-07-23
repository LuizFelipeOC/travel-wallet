import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_wallet/app/core/storage/local_storage.dart';
import 'package:travel_wallet/app/core/storage/local_storage_interface.dart';

void main() {
  group('Localstorage', () {
    test('returns failure when key is empty on get', () async {
      final storage = Localstorage();

      final result = await storage.get(key: '');

      expect(result, isA<LocalStorageFailure>());
      expect((result as LocalStorageFailure).message, 'Key cannot be empty');
    });

    test('returns failure when key is empty on set', () async {
      final storage = Localstorage();

      final result = await storage.set(key: '', value: true);

      expect(result, isA<LocalStorageFailure>());
      expect((result as LocalStorageFailure).message, 'Key cannot be empty');
    });

    test('stores and retrieves supported primitive types', () async {
      SharedPreferences.setMockInitialValues({});
      final storage = Localstorage();

      final cases = <({String key, dynamic value})>[
        (key: 'bool_key', value: true),
        (key: 'int_key', value: 42),
        (key: 'double_key', value: 3.14),
        (key: 'string_key', value: 'travel-wallet'),
        (key: 'list_key', value: <String>['a', 'b']),
      ];

      for (final testCase in cases) {
        final setResult = await storage.set(key: testCase.key, value: testCase.value);
        final getResult = await storage.get(key: testCase.key);

        expect(setResult, isA<LocalStorageSuccess<dynamic>>());
        expect(getResult, isA<LocalStorageSuccess<dynamic>>());
        expect((getResult as LocalStorageSuccess).data, equals(testCase.value));
      }
    });
  });
}
