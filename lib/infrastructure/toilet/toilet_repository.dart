import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unchicchi/domain/toilet/toilet_id.dart';
import 'package:unchicchi/domain/toilet/toilet.dart';
import 'package:unchicchi/infrastructure/toilet/i_toilet_repository.dart';

final toiletRepositoryProvider = Provider((ref) => ToiletRepository());

class ToiletRepository implements IToiletRepository {
  @override
  Toilet? find(ToiletId toiletId) {
    return Hive.box<Toilet>('toilet').get(toiletId.value);
  }

  @override
  Future<List<Toilet>> findAll() async {
    final box = await Hive.openBox<Toilet>('toilet');
    return box.values.toList();
  }

  @override
  Future<void> save(Toilet toilet) async {
    await Hive.box<Toilet>('toilet').put(toilet.toiletId.value, toilet);
  }

  @override
  Future<void> update(ToiletId toiletId, Toilet toilet) async {
    await Hive.box<Toilet>('toilet').put(toiletId.value, toilet);
  }

  @override
  Future<void> delete(ToiletId toiletId) async {
    await Hive.box<Toilet>('toilet').delete(toiletId.value);
  }

  // 年月を選択したものを返す
  @override
  Future<List<Toilet>> findByDate(DateTime date) async {
    final List<Toilet> toilets = await findAll();
    return toilets
        .where(
          (toilet) =>
              DateTime(toilet.toiletDate.value.year,
                  toilet.toiletDate.value.month) ==
              DateTime(date.year, date.month),
        )
        .toList();
  }
}
