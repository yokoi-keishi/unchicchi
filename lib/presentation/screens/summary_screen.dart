import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unchicchi/presentation/notifier/toilet_summary_notifier.dart';
import 'package:unchicchi/presentation/providers/common/tab_index_provider.dart';
import 'package:unchicchi/presentation/widgets/common/common_container.dart';
import 'package:unchicchi/presentation/widgets/common/common_tab_item.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SummaryScreen extends HookConsumerWidget {
  const SummaryScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(toiletSummaryNotiferProvider);
    final notifier = ref.watch(toiletSummaryNotiferProvider.notifier);

    useMemoized(() async => await notifier.findAll());

    final year = useState(DateTime.now().year);
    final month = useState(DateTime.now().month);

    List<int> pulldownYearList = List<int>.generate(
      DateTime.now().year - 2022 + 1,
      (i) => 2022 + i,
    );
    List<int> pulldownMonthList = List<int>.generate(
      12,
      (i) => i + 1,
    );

    return Container(
      color: tabNavigatorBackgroundColor[ref.watch(tabIndexProvider)],
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CommonContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: const Text(
                      "表示",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 75,
                    child: DropdownButtonFormField<int>(
                      alignment: AlignmentDirectional.center,
                      value: year.value,
                      hint: const Text('---'),
                      items: pulldownYearList
                          .map(
                            (value) => DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            ),
                          )
                          .toList(),
                      onChanged: (int? year) async {
                        await notifier.findByDate(
                            year ?? DateTime.now().year, month.value);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: const Text(
                      "年",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: DropdownButtonFormField<int>(
                      value: month.value,
                      hint: const Text('---'),
                      items: pulldownMonthList
                          .map(
                            (value) => DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            ),
                          )
                          .toList(),
                      onChanged: (int? month) async {
                        await notifier.findByDate(
                            year.value, month ?? DateTime.now().month);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: const Text(
                      "月",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            state.toilets.isEmpty
                ? const Center(
                    child: Text('データがありません'),
                  )
                : CommonContainer(
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 60,
                              sections: notifier.showingSections(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: notifier.showingPieNameView(),
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }
}
