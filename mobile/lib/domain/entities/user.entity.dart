import 'package:immich_mobile/domain/models/user.model.dart';
import 'package:immich_mobile/domain/utils/isar_helpers.dart';
import 'package:isar/isar.dart';

part 'user.entity.g.dart';

@Collection(inheritance: false, accessor: 'usr')
class UserEntity {
  Id get isarId => IsarHelpers.fastHash(id);

  @Index(unique: true, replace: false, type: IndexType.hash)
  final String id;
  final DateTime updatedAt;
  final String name;
  final String email;
  final bool isAdmin;
  final int quotaSizeInBytes;
  final int quotaUsageInBytes;
  final bool inTimeline;
  final String profileImagePath;
  final bool memoryEnabled;
  @Enumerated(EnumType.ordinal)
  final UserAvatarColor avatarColor;

  const UserEntity({
    required this.id,
    required this.updatedAt,
    required this.name,
    required this.email,
    required this.isAdmin,
    required this.quotaSizeInBytes,
    required this.quotaUsageInBytes,
    required this.inTimeline,
    required this.profileImagePath,
    required this.memoryEnabled,
    required this.avatarColor,
  });
}
