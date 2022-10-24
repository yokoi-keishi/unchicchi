import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unchicchi/application/toilet/state/toilet_summary_state.dart';
import 'package:unchicchi/application/toilet/toilet_app_service.dart';
import 'package:unchicchi/presentation/widgets/summary/indicator.dart';

final toiletSummaryNotiferProvider =
    StateNotifierProvider<ToiletSummaryNotifier, ToiletSummaryState>((ref) =>
        ToiletSummaryNotifier(
            ToiletSummaryState.init(), ref.watch(toiletAppServiceProvider)));

class ToiletSummaryNotifier extends StateNotifier<ToiletSummaryState> {
  ToiletSummaryNotifier(super.state, this.toiletAppService);
  ToiletAppService toiletAppService;

  // 初期セット
  Future<void> findAll() async {
    state.isLoading = true;
    final toilets = await toiletAppService.findAll();
    state = state.copyWith(toilets: toilets, isLoading: false);
  }

  // 年と月指定
  Future<void> findByDate(int year, int month) async {
    state.isLoading = true;
    final toilets = await toiletAppService.findByDate(year, month);
    state = state.copyWith(toilets: toilets, isLoading: false);
  }

  // レベルに合わせたカラー
  Color randomColor(int index) {
    switch (index) {
      case 0:
        return Colors.brown;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  // PIEを作る
  List<PieChartSectionData>? showingSections() {
    return state.toilets.isEmpty
        ? null
        : List.generate(3, (i) {
            final applicableList =
                state.toilets.where((toilet) => toilet.level == i).toList();

            if (applicableList.isEmpty) {
              return PieChartSectionData(
                color: randomColor(i),
                value: 0,
                title: '0%',
                titleStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffffffff),
                ),
              );
            }

            final ratio = (applicableList.length / state.toilets.length) * 100;

            return PieChartSectionData(
              color: randomColor(i),
              value: ratio,
              title: '${ratio.toStringAsFixed(1)}%',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            );
          });
  }

  // PIEの下の説明タイトル
  List<StatelessWidget> showingPieNameView() {
    return List.generate(3, (i) {
      final applicableList =
          state.toilets.where((toilet) => toilet.level == i).toList();

      if (applicableList.isEmpty) return Container();

      return Indicator(
        color: randomColor(i),
        text: '${applicableList.first.level2Text} ${applicableList.length}回',
        isSquare: false,
      );
    });
  }

}
