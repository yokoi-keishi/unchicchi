import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unchicchi/domain/toilet/i_toilet_factory.dart';
import 'package:unchicchi/domain/toilet/toilet_level.dart';
import 'package:unchicchi/domain/toilet/toilet_id.dart';
import 'package:unchicchi/domain/toilet/toilet_date.dart';
import 'package:unchicchi/domain/toilet/toilet.dart';

final toiletFactoryProvider = Provider((ref) => ToiletFactory());

class ToiletFactory implements IToiletFactory {
  @override
  Toilet create(String toiletId, int toiletLevel, DateTime toiletDate) {
    return Toilet(
      ToiletId(toiletId),
      ToiletLevel(toiletLevel),
      ToiletDate(toiletDate),
    );
  }
}
