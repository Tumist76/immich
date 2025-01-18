import 'dart:async';

import 'package:immich_mobile/domain/interfaces/store.interface.dart';
import 'package:immich_mobile/domain/models/store.model.dart';

typedef _StoreCache = Map<int, dynamic>;

class StoreUnInitializedException implements Exception {
  const StoreUnInitializedException();

  @override
  String toString() => "Store not initialized. Call init()";
}

final class Store {
  final IStoreRepository _storeRepository;
  _StoreCache _cache = {};

  late final StreamSubscription<StoreUpdateEvent> _subscription;

  Store(IStoreRepository storeRepository) : _storeRepository = storeRepository {
    unawaited(_populateCache().then((_) => _subscription = _listenForChange()));
  }

  /// Fills the cache with the values from the DB
  Future<void> _populateCache() async {
    for (StoreKey key in StoreKey.values) {
      final value = await _storeRepository.tryGet(key);
      if (value != null) {
        _cache[key.id] = value;
      }
    }
  }

  /// Listens for changes in the DB and updates the cache
  StreamSubscription<StoreUpdateEvent> _listenForChange() =>
      _storeRepository.watchAll().listen((event) {
        _cache[event.key.id] = event.value;
      });

  /// Disposes the store and cancels the subscription. To reuse the store call init() again
  void dispose() async {
    await _subscription.cancel();
    _cache = {};
  }

  /// Returns the stored value for the given key (possibly null)
  // ignore: avoid-unnecessary-nullable-return-type
  T? tryGet<T, U>(StoreKey<T, U> key) => _cache[key.id];

  /// Returns the stored value for the given key or if null the [defaultValue]
  /// Throws a [StoreKeyNotFoundException] if both are null
  T get<T, U>(StoreKey<T, U> key, [T? defaultValue]) {
    final value = tryGet(key) ?? defaultValue;
    if (value == null) {
      throw StoreKeyNotFoundException(key);
    }
    return value;
  }

  /// Asynchronously stores the value in the DB and synchronously in the cache
  Future<void> put<T, U>(StoreKey<T, U> key, T value) async {
    if (_cache[key.id] == value) return;

    await _storeRepository.insert(key, value);
    _cache[key.id] = value;
  }

  /// Watches a specific key for changes
  Stream<T?> watch<T, U>(StoreKey<T, U> key) => _storeRepository.watch(key);

  /// Removes the value asynchronously from the DB and synchronously from the cache
  Future<void> delete<T, U>(StoreKey<T, U> key) async {
    await _storeRepository.delete(key);
    _cache.remove(key.id);
  }

  /// Clears all values from this store (cache and DB), only for testing!
  Future<void> clear() async {
    await _storeRepository.deleteAll();
    _cache = {};
  }
}
