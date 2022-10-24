import 'package:unchicchi/domain/toilet/toilet.dart';

/// UIでドメインオブジェクトの振る舞いを制限する
/// Application ServiceでUIに渡すときに使う
class ToiletDto {
  late String id;
  int? level;
  DateTime? date;
  String? level2Text;

  ToiletDto(Toilet source) {
    id = source.toiletId.value;
    level = source.toiletLevel.value;
    date = source.toiletDate.value;
    level2Text = source.toiletLevel.level2Text();
  }
}
