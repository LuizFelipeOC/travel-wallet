import '../../infraestructure/infraestructure.dart';

class CheckAccessRepository {
  final ILocalStorage localStorage;

  CheckAccessRepository({required this.localStorage});

  Future<bool> checkHasFirstTimeUser() async {
    final isFirstTimeUser = await localStorage.get(key: 'is_first_time_user');

    switch (isFirstTimeUser) {
      case LocalStorageSuccess(data: final access):
        return access == true;
      case LocalStorageFailure(message: final message):
        throw Exception('Failed to retrieve access: $message');
    }
  }

  Future<void> setFirstTimeUser() async {
    final result = await localStorage.set(key: 'is_first_time_user', value: true);

    switch (result) {
      case LocalStorageSuccess(data: _):
        return;
      case LocalStorageFailure(message: final message):
        throw Exception('Failed to set access: $message');
    }
  }
}
