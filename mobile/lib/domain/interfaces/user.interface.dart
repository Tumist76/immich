import 'package:immich_mobile/domain/models/user.model.dart';

abstract interface class IUserRepository {
  Future<User?> get(String id);
}
