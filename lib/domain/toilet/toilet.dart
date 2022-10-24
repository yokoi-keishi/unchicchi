import 'package:hive_flutter/hive_flutter.dart';
import 'package:unchicchi/domain/toilet/toilet_date.dart';
import 'package:unchicchi/domain/toilet/toilet_id.dart';
import 'package:unchicchi/domain/toilet/toilet_level.dart';

part 'toilet.g.dart';

@HiveType(typeId: 1)
class Toilet {
  @HiveField(0)
  final ToiletId toiletId;

  @HiveField(1)
  ToiletLevel toiletLevel;

  @HiveField(2)
  ToiletDate toiletDate;

  Toilet(this.toiletId, this.toiletLevel, this.toiletDate);

}
