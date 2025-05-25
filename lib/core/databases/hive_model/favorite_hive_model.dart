import 'package:hive_ce_flutter/hive_flutter.dart';
part 'favorite_hive_model.g.dart';

@HiveType(typeId: 1)
class FavoriteHiveModel extends HiveObject {
  @HiveField(0)
  String entityId;

  @HiveField(1)
  DateTime addedAt;

  @HiveField(2)
  int? order;

  FavoriteHiveModel({
    required this.entityId,
    required this.addedAt,
    this.order,
  });
}
