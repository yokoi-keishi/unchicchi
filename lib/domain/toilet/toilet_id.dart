import 'package:hive_flutter/hive_flutter.dart';

part 'toilet_id.g.dart';

@HiveType(typeId: 2)
class ToiletId {
  @HiveField(0)
  final String value;

  ToiletId(this.value);
}
