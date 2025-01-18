import 'dart:async';

import 'package:immich_mobile/domain/entities/store.entity.dart';
import 'package:immich_mobile/domain/interfaces/database.interface.dart';
import 'package:immich_mobile/domain/interfaces/store.interface.dart';
import 'package:immich_mobile/domain/models/store.model.dart';
import 'package:immich_mobile/domain/repositories/database.repository.dart';
import 'package:isar/isar.dart';

class StoreRepository extends IsarDatabaseRepository
    implements IStoreRepository, IDatabaseRepository {
  final Isar _db;
  const StoreRepository({required super.db}) : _db = db;

  @override
  Future<bool> insert<T, U>(StoreKey<T, U> key, T value) async {
    await nestTxn(() async => await _db.store.put(key.toEntity(value)));
    return true;
  }

  @override
  Future<T> get<T, U>(StoreKey<T, U> key) async {
    final value = await tryGet(key);
    if (value == null) {
      throw StoreKeyNotFoundException(key);
    }
    return value;
  }

  @override
  Future<T?> tryGet<T, U>(StoreKey<T, U> key) {
    return _db.txn(() async {
      final entity = await _db.store.get(key.id);
      return entity?.toValue(key, _db);
    });
  }

  @override
  Stream<T?> watch<T, U>(StoreKey<T, U> key) {
    return _db.store.watchObject(key.id).asyncMap((e) => e?.toValue(key, _db));
  }

  @override
  Stream<StoreUpdateEvent> watchAll() {
    return _db.store
        .where()
        .watch()
        .expand((entities) => entities.map((e) => e.toUpdateEvent(_db)));
  }

  @override
  Future<bool> update<T, U>(StoreKey<T, U> key, T value) async {
    await nestTxn(() async => await _db.store.put(key.toEntity(value)));
    return true;
  }

  @override
  Future<void> delete<T, U>(StoreKey<T, U> key) {
    return nestTxn(() async {
      await _db.store.delete(key.id);
    });
  }

  @override
  Future<void> deleteAll() {
    return nestTxn(() async {
      await _db.store.clear();
    });
  }
}

extension _ModelToEntity<T, U> on StoreKey<T, U> {
  StoreEntity toEntity(T value) {
    final storeValue = converter.toPrimitive(value);
    final intValue = (type == int) ? storeValue as int : null;
    final strValue = (type == String) ? storeValue as String : null;
    return StoreEntity(id: id, intValue: intValue, strValue: strValue);
  }
}

extension _EntityToModel on StoreEntity {
  StoreUpdateEvent toUpdateEvent(Isar db) {
    final key = StoreKey.values.firstWhere((e) => e.id == id);
    final value = toValue(key, db);
    return StoreUpdateEvent(key, value);
  }

  Future<T?> toValue<T, U>(StoreKey<T, U> key, Isar db) async {
    final primitive = switch (key.type) {
      const (int) => intValue,
      const (String) => strValue,
      _ => null,
    } as U?;
    if (primitive != null) {
      return await key.converter.fromPrimitive(primitive, db);
    }
    return null;
  }
}
