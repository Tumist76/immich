// ignore_for_file: avoid-dynamic

import 'package:immich_mobile/domain/interfaces/store.interface.dart';
import 'package:immich_mobile/domain/models/user.model.dart';
import 'package:immich_mobile/domain/repositories/user.repository.dart';
import 'package:isar/isar.dart';

class StoreStringConverter extends IStoreConverter<String, String> {
  const StoreStringConverter();

  @override
  String fromPrimitive(String value, [dynamic db]) => value;

  @override
  String toPrimitive(String value) => value;
}

class StoreIntConverter extends IStoreConverter<int, int> {
  const StoreIntConverter();

  @override
  int fromPrimitive(int value, [dynamic db]) => value;

  @override
  int toPrimitive(int value) => value;
}

class StoreBoolConverter extends IStoreConverter<bool, int> {
  const StoreBoolConverter();

  @override
  bool fromPrimitive(int value, [dynamic db]) => value != 0;

  @override
  int toPrimitive(bool value) => value ? 1 : 0;
}

class StoreDateTimeConverter extends IStoreConverter<DateTime, int> {
  const StoreDateTimeConverter();

  @override
  DateTime fromPrimitive(int value, [dynamic db]) =>
      DateTime.fromMicrosecondsSinceEpoch(value);

  @override
  int toPrimitive(DateTime value) => value.microsecondsSinceEpoch;
}

class StoreUserConverter extends IStoreConverter<User, String> {
  const StoreUserConverter();

  @override
  Future<User?> fromPrimitive(String value, dynamic db) async {
    if (db is Isar) {
      final userRepository = UserRepository(db: db);
      return await userRepository.get(value);
    }
    return null;
  }

  @override
  String toPrimitive(User value) => value.id;
}
