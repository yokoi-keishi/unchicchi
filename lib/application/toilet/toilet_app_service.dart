import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unchicchi/application/toilet/command/toilet_create_command.dart';
import 'package:unchicchi/application/toilet/command/toilet_update_command.dart';
import 'package:unchicchi/application/toilet/dto/toilet_dto.dart';
import 'package:unchicchi/domain/toilet/i_toilet_factory.dart';
import 'package:unchicchi/domain/toilet/toilet.dart';
import 'package:unchicchi/domain/toilet/toilet_factory.dart';
import 'package:unchicchi/domain/toilet/toilet_id.dart';
import 'package:unchicchi/infrastructure/toilet/i_toilet_repository.dart';
import 'package:unchicchi/infrastructure/toilet/toilet_repository.dart';

final toiletAppServiceProvider = Provider(
  (ref) => ToiletAppService(
      ref.watch(toiletFactoryProvider), ref.watch(toiletRepositoryProvider)),
);

class ToiletAppService {
  final IToiletFactory toiletFactory;
  final IToiletRepository toiletRepository;

  ToiletAppService(this.toiletFactory, this.toiletRepository);

  Future<List<ToiletDto>> findAll() async {
    final toilets = await toiletRepository.findAll();
    // Dtoに変換
    return toilets.map((toilet) => ToiletDto(toilet)).toList();
  }

  void create(ToiletCreateCommand command) async {
    final toilet = toiletFactory.create(
      command.id,
      command.level,
      command.date,
    );

    await toiletRepository.save(toilet);
  }

  ToiletDto? find(String id) {
    final toilet = toiletRepository.find(ToiletId(id));
    return toilet != null ? ToiletDto(toilet) : null;
  }

  void update(ToiletUpdateCommand command) async {
    final toilet =
        toiletFactory.create(command.id, command.level, command.date);
    await toiletRepository.update(
      ToiletId(command.id),
      toilet,
    );
  }

  void delete(String id) async {
    await toiletRepository.delete(ToiletId(id));
  }

  // 年と月のみ一致したものを返す
  Future<List<ToiletDto>> findByDate(int year, int month) async {
    final date = DateTime(year, month); 
    final toilets = await toiletRepository.findByDate(date);
    return toilets.map((toilet) => ToiletDto(toilet)).toList();
  }
}
