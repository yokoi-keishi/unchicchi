import 'package:hive_flutter/hive_flutter.dart';

part 'toilet_date.g.dart';

@HiveType(typeId: 4)
class ToiletDate {
  @HiveField(0)
  final DateTime value;

  ToiletDate(this.value);

}
