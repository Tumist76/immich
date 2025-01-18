import 'dart:ui';

class User {
  const User({
    required this.dbId,
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
    required this.updatedAt,
    required this.avatarColor,
    required this.profileImagePath,
    required this.memoryEnabled,
    required this.inTimeline,
    required this.quotaSizeInBytes,
    required this.quotaUsageInBytes,
  });

  final int dbId;
  final String id;
  final DateTime updatedAt;
  final String name;
  final String email;
  final bool isAdmin;
  // Quota
  final int quotaSizeInBytes;
  final int quotaUsageInBytes;
  // Sharing
  final bool inTimeline;
  // User prefs
  final String profileImagePath;
  final bool memoryEnabled;
  final UserAvatarColor avatarColor;

  User copyWith({
    int? dbId,
    String? id,
    DateTime? updatedAt,
    String? name,
    String? email,
    bool? isAdmin,
    int? quotaSizeInBytes,
    int? quotaUsageInBytes,
    bool? inTimeline,
    String? profileImagePath,
    bool? memoryEnabled,
    UserAvatarColor? avatarColor,
  }) {
    return User(
      dbId: dbId ?? this.dbId,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,
      updatedAt: updatedAt ?? this.updatedAt,
      avatarColor: avatarColor ?? this.avatarColor,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      memoryEnabled: memoryEnabled ?? this.memoryEnabled,
      inTimeline: inTimeline ?? this.inTimeline,
      quotaSizeInBytes: quotaSizeInBytes ?? this.quotaSizeInBytes,
      quotaUsageInBytes: quotaUsageInBytes ?? this.quotaUsageInBytes,
    );
  }

  @override
  String toString() {
    return '''User: {
      dbId: $dbId,
      id: $id,
      updatedAt: $updatedAt,
      name: $name,
      email: $email,
      isAdmin: $isAdmin,
      quotaSizeInBytes: $quotaSizeInBytes,
      quotaUsageInBytes: $quotaUsageInBytes,
      inTimeline: $inTimeline,
      profileImagePath: $profileImagePath,
      memoryEnabled: $memoryEnabled,
      avatarColor: $avatarColor,
    }''';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.dbId == dbId &&
        other.id == id &&
        other.updatedAt == updatedAt &&
        other.name == name &&
        other.email == email &&
        other.isAdmin == isAdmin &&
        other.quotaSizeInBytes == quotaSizeInBytes &&
        other.quotaUsageInBytes == quotaUsageInBytes &&
        other.inTimeline == inTimeline &&
        other.profileImagePath == profileImagePath &&
        other.memoryEnabled == memoryEnabled &&
        other.avatarColor == avatarColor;
  }

  @override
  int get hashCode {
    return dbId.hashCode ^
        id.hashCode ^
        updatedAt.hashCode ^
        name.hashCode ^
        email.hashCode ^
        isAdmin.hashCode ^
        quotaSizeInBytes.hashCode ^
        quotaUsageInBytes.hashCode ^
        inTimeline.hashCode ^
        profileImagePath.hashCode ^
        memoryEnabled.hashCode ^
        avatarColor.hashCode;
  }
}

enum UserAvatarColor {
  // do not change this order or reuse indices for other purposes, adding is OK
  primary,
  pink,
  red,
  yellow,
  blue,
  green,
  purple,
  orange,
  gray,
  amber;

  Color toColor([bool isDarkTheme = false]) => switch (this) {
        UserAvatarColor.primary =>
          isDarkTheme ? const Color(0xFFABCBFA) : const Color(0xFF4250AF),
        UserAvatarColor.pink => const Color.fromARGB(255, 244, 114, 182),
        UserAvatarColor.red => const Color.fromARGB(255, 239, 68, 68),
        UserAvatarColor.yellow => const Color.fromARGB(255, 234, 179, 8),
        UserAvatarColor.blue => const Color.fromARGB(255, 59, 130, 246),
        UserAvatarColor.green => const Color.fromARGB(255, 22, 163, 74),
        UserAvatarColor.purple => const Color.fromARGB(255, 147, 51, 234),
        UserAvatarColor.orange => const Color.fromARGB(255, 234, 88, 12),
        UserAvatarColor.gray => const Color.fromARGB(255, 75, 85, 99),
        UserAvatarColor.amber => const Color.fromARGB(255, 217, 119, 6),
      };
}
