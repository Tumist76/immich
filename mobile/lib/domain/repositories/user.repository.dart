import 'package:immich_mobile/domain/entities/user.entity.dart';
import 'package:immich_mobile/domain/interfaces/database.interface.dart';
import 'package:immich_mobile/domain/interfaces/user.interface.dart';
import 'package:immich_mobile/domain/models/user.model.dart';
import 'package:immich_mobile/domain/repositories/database.repository.dart';
import 'package:isar/isar.dart';

class UserRepository extends IsarDatabaseRepository
    implements IUserRepository, IDatabaseRepository {
  final Isar _db;
  const UserRepository({required super.db}) : _db = db;

  @override
  Future<User?> get(String id) {
    return _db.txn(() async {
      final entity = await _db.usr.where().idEqualTo(id).findFirst();
      return entity?.fromEntity();
    });
  }
}

extension _EntityToModel on UserEntity {
  User fromEntity() => User(
        dbId: isarId,
        id: id,
        name: name,
        email: email,
        isAdmin: isAdmin,
        updatedAt: updatedAt,
        avatarColor: avatarColor,
        profileImagePath: profileImagePath,
        memoryEnabled: memoryEnabled,
        inTimeline: inTimeline,
        quotaSizeInBytes: quotaSizeInBytes,
        quotaUsageInBytes: quotaUsageInBytes,
      );
}
