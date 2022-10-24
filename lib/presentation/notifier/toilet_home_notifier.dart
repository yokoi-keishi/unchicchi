import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unchicchi/application/toilet/command/toilet_create_command.dart';
import 'package:unchicchi/application/toilet/command/toilet_update_command.dart';
import 'package:unchicchi/application/toilet/dto/toilet_dto.dart';
import 'package:unchicchi/application/toilet/state/toilet_home_state.dart';
import 'package:unchicchi/application/toilet/toilet_app_service.dart';
import 'package:unchicchi/presentation/widgets/home/event_marker.dart';
import 'package:uuid/uuid.dart';

final toiletHomeNotiferProvider =
    StateNotifierProvider<ToiletNomeNotifier, ToiletHomeState>((ref) =>
        ToiletNomeNotifier(
            ToiletHomeState.init(), ref.watch(toiletAppServiceProvider)));

class ToiletNomeNotifier extends StateNotifier<ToiletHomeState> {
  ToiletNomeNotifier(super.state, this.toiletAppService);

  ToiletAppService toiletAppService;

  List<String> levels = ['硬め', '普通', '下痢気味'];

  // 初期セット
  Future<void> initToiletSet() async {
    state.isLoading = true;
    final toilets = await toiletAppService.findAll();
    state = state.copyWith(toilets: toilets, isLoading: false);
  }

  // 保存処理
  void saveToilet(int level, DateTime date) async {
    final command = ToiletCreateCommand(
      const Uuid().v4(),
      level,
      date,
    );
    toiletAppService.create(command);
  }

  // 削除
  void deleteToilet(String id) {
    toiletAppService.delete(id);

    final newList =
        state.toilets.where((toiletDto) => toiletDto.id != id).toList();

    state = state.copyWith(toilets: [...newList]);
  }

  // 更新
  void updateToilet(String id, int level, DateTime date) async {
    toiletAppService.update(ToiletUpdateCommand(id, level, date));

    final toilets = await toiletAppService.findAll();
    state = state.copyWith(toilets: toilets, isLoading: false);
  }

  // カレンダーにイベントを表示
  List<int?> showCalendarEvents(DateTime day) {
    final result = state.toilets
        .where((toiletDto) =>
            DateTime(toiletDto.date!.year, toiletDto.date!.month,
                toiletDto.date!.day) ==
            DateTime(day.year, day.month, day.day))
        .toList();
    return result.map((toiletDto) => toiletDto.level).toList();
  }

  // イベントのマーカ
  Widget showEventMarker(context, day, event) {
    switch (event) {
      case 1:
        return const EventMarker(color: Colors.orange);
      case 2:
        return const EventMarker(color: Colors.brown);
      case 3:
        return const EventMarker(color: Colors.black87);
      default:
        return const EventMarker(color: Colors.brown);
    }
  }

  // カレンダー選択した日付のデータ
  List<ToiletDto> calendarSelected(DateTime day) {
    final result = state.toilets
        .where((toiletDto) =>
            DateTime(toiletDto.date!.year, toiletDto.date!.month,
                toiletDto.date!.day) ==
            DateTime(day.year, day.month, day.day))
        .toList();
    return result;
  }
}
