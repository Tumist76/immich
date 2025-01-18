// ignore_for_file: avoid-dynamic

import 'dart:async';

import 'package:immich_mobile/domain/models/store.model.dart';

abstract class IStoreConverter<T, U> {
  const IStoreConverter();

  /// Converts the value back to T? from the primitive type U from the db
  FutureOr<T?> fromPrimitive(U value, dynamic db);

  /// Converts the value T to the primitive type U supported by the Store
  U toPrimitive(T value);
}

abstract interface class IStoreRepository {
  Future<bool> insert<T, U>(StoreKey<T, U> key, T value);

  Future<T> get<T, U>(StoreKey<T, U> key);

  Future<T?> tryGet<T, U>(StoreKey<T, U> key);

  Stream<T?> watch<T, U>(StoreKey<T, U> key);

  Stream<StoreUpdateEvent> watchAll();

  Future<bool> update<T, U>(StoreKey<T, U> key, T value);

  Future<void> delete<T, U>(StoreKey<T, U> key);

  Future<void> deleteAll();
}
