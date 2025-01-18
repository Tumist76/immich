import 'package:immich_mobile/domain/interfaces/store.interface.dart';
import 'package:immich_mobile/domain/models/user.model.dart';
import 'package:immich_mobile/domain/utils/store_converters.dart';

/// Key for each possible value in the `Store`.
/// Defines the data type for each value
enum StoreKey<T, U> {
  version<int, int>._(0, type: int),
  assetETag<String, String>._(1, type: String),
  currentUser<User, String>._(2, type: User, converter: StoreUserConverter()),
  deviceIdHash<int, int>._(3, type: int),
  deviceId<String, String>._(4, type: String),
  backupFailedSince<DateTime, int>._(5, type: DateTime),
  backupRequireWifi<bool, int>._(6, type: bool),
  backupRequireCharging<bool, int>._(7, type: bool),
  backupTriggerDelay<int, int>._(8, type: int),
  serverUrl<String, String>._(10, type: String),
  accessToken<String, String>._(11, type: String),
  serverEndpoint<String, String>._(12, type: String),
  autoBackup<bool, int>._(13, type: bool),
  backgroundBackup<bool, int>._(14, type: bool),
  // TODO: Refactor to use a converter and a single value
  sslClientCertData<String, String>._(15, type: String),
  sslClientPasswd<String, String>._(16, type: String),
  loadPreview<bool, int>._(100, type: bool),
  loadOriginal<bool, int>._(101, type: bool),
  themeMode<String, String>._(102, type: String),
  tilesPerRow<int, int>._(103, type: int),
  dynamicLayout<bool, int>._(104, type: bool),
  groupAssetsBy<int, int>._(105, type: int),
  uploadErrorNotificationGracePeriod<int, int>._(106, type: int),
  backgroundBackupTotalProgress<bool, int>._(107, type: bool),
  backgroundBackupSingleProgress<bool, int>._(108, type: bool),
  storageIndicator<bool, int>._(109, type: bool),
  thumbnailCacheSize<int, int>._(110, type: int),
  imageCacheSize<int, int>._(111, type: int),
  albumThumbnailCacheSize<int, int>._(112, type: int),
  selectedAlbumSortOrder<int, int>._(113, type: int),
  advancedTroubleshooting<bool, int>._(114, type: bool),
  logLevel<int, int>._(115, type: int),
  preferRemoteImage<bool, int>._(116, type: bool),
  loopVideo<bool, int>._(117, type: bool),
  // Map related
  mapShowFavoriteOnly<bool, int>._(118, type: bool),
  mapRelativeDate<int, int>._(119, type: int),
  mapIncludeArchived<bool, int>._(121, type: bool),
  mapThemeMode<int, int>._(124, type: int),
  mapwithPartners<bool, int>._(125, type: bool),
  selfSignedCert<bool, int>._(120, type: bool),
  ignoreIcloudAssets<bool, int>._(122, type: bool),
  selectedAlbumSortReverse<bool, int>._(123, type: bool),
  enableHapticFeedback<bool, int>._(126, type: bool),
  customHeaders<String, String>._(127, type: String),
  primaryColor<String, String>._(128, type: String),
  dynamicTheme<bool, int>._(129, type: bool),
  colorfulInterface<bool, int>._(130, type: bool),
  syncAlbums<bool, int>._(131, type: bool),
  autoEndpointSwitching<bool, int>._(132, type: bool),
  preferredWifiName<String, String>._(133, type: String),
  localEndpoint<String, String>._(134, type: String),
  externalEndpointList<String, String>._(135, type: String),
  loadOriginalVideo<bool, int>._(136, type: bool),
  ;

  const StoreKey._(
    this.id, {
    required this.type,
    IStoreConverter<T, U>? converter,
  }) : _converter = converter;

  final int id;
  final Type type;
  final IStoreConverter<T, U>? _converter;
  IStoreConverter<T, U> get converter =>
      _converter ??
      switch (type) {
        const (int) => const StoreIntConverter() as IStoreConverter<T, U>,
        const (String) => const StoreStringConverter() as IStoreConverter<T, U>,
        const (bool) => const StoreBoolConverter() as IStoreConverter<T, U>,
        const (DateTime) =>
          const StoreDateTimeConverter() as IStoreConverter<T, U>,
        _ => throw StoreUnkownTypeException(this),
      };
}

class StoreUpdateEvent<T, U> {
  final StoreKey<T, U> key;
  final T value;

  const StoreUpdateEvent(this.key, this.value);
}

class StoreKeyNotFoundException implements Exception {
  final StoreKey key;
  const StoreKeyNotFoundException(this.key);

  @override
  String toString() => "Key '${key.name}' not found in Store";
}

class StoreUnkownTypeException implements Exception {
  final StoreKey key;
  const StoreUnkownTypeException(this.key);

  @override
  String toString() =>
      "Key '${key.name}' cannot be transformed to the required type ${key.type} from the store";
}
