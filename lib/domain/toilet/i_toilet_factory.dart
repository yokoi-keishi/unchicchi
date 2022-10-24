import 'package:unchicchi/domain/toilet/toilet.dart';
import 'package:unchicchi/domain/toilet/toilet_date.dart';
import 'package:unchicchi/domain/toilet/toilet_id.dart';
import 'package:unchicchi/domain/toilet/toilet_level.dart';

abstract class IToiletFactory {
  Toilet create(
      String toiletId, int toiletLevel, DateTime toiletDate);
}
