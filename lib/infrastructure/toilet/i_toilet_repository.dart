import 'package:unchicchi/domain/toilet/toilet.dart';
import 'package:unchicchi/domain/toilet/toilet_id.dart';

abstract class IToiletRepository {
  Future<List<Toilet>> findAll();
  Future<void> save(Toilet toilet);
  Toilet? find(ToiletId toiletId);
  Future<void> update(ToiletId toiletId, Toilet toilet);
  Future<void> delete(ToiletId toiletId);
  Future<List<Toilet>> findByDate(DateTime date);
}
