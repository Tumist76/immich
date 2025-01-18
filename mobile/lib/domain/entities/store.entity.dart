import 'package:isar/isar.dart';

part 'store.entity.g.dart';

@Collection(inheritance: false, accessor: 'store')
class StoreEntity {
  final Id id;
  final int? intValue;
  final String? strValue;

  const StoreEntity({required this.id, this.intValue, this.strValue});
}
