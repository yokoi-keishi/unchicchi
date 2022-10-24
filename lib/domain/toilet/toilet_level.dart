import 'package:hive_flutter/hive_flutter.dart';

part 'toilet_level.g.dart';

@HiveType(typeId: 3)
class ToiletLevel {
  @HiveField(0)
  final int value;

  ToiletLevel(this.value) {
    // レベルは0~6と定義
    if (value < 0 || value > 2) {
      throw Exception('レベルに間違いがあります');
    }
  }

  String level2Text() {
      switch (value) {
        case 0:
          return '硬め';
        case 1:
          return '普通';
        case 2:
          return '下痢気味';
        default:
          throw Exception('レベルの範囲を超えている');
      }
    }

}
