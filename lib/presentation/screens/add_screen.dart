import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:unchicchi/presentation/notifier/toilet_home_notifier.dart';
import 'package:unchicchi/presentation/providers/common/tab_index_provider.dart';
import 'package:unchicchi/presentation/widgets/common/common_container.dart';
import 'package:unchicchi/presentation/widgets/common/common_dialog.dart';
import 'package:unchicchi/presentation/widgets/common/common_tab_item.dart';

class AddScreen extends HookConsumerWidget {
  const AddScreen({super.key, this.date});

  final DateTime? date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    final notifier = ref.watch(toiletHomeNotiferProvider.notifier);

    final ValueNotifier<int?> selectedLevel = useState(null);
    final ValueNotifier<DateTime> selectedDate =
        useState(date ?? DateTime.now());
    final isTapped = useState(false);

    Widget choiceItem(int level, String levelDetail) {
      return InkWell(
        onTap: () => selectedLevel.value = level,
        child: Container(
            padding: const EdgeInsets.all(15),
            color: selectedLevel.value == level ? Colors.grey : Colors.white,
            child: Center(
                child: Text(
              levelDetail,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ))),
      );
    }

    void _showDialog(Widget child) {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => Container(
                height: 216,
                padding: const EdgeInsets.only(top: 6.0),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                color: CupertinoColors.systemBackground.resolveFrom(context),
                child: SafeArea(
                  top: false,
                  child: child,
                ),
              ));
    }

    return Container(
      padding: const EdgeInsets.all(20),
      color: tabNavigatorBackgroundColor[ref.watch(tabIndexProvider)],
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CommonContainer(
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                TextButton(
                  onPressed: () async {
                    _showDialog(CupertinoDatePicker(
                      initialDateTime: selectedDate.value,
                      mode: CupertinoDatePickerMode.date,
                      dateOrder: DatePickerDateOrder.ymd,
                      onDateTimeChanged: (DateTime newDate) {
                        selectedDate.value = newDate;
                      },
                    ));
                  },
                  child: Text(
                    format.format(selectedDate.value),
                    style: const TextStyle(
                        fontSize: 16, decoration: TextDecoration.underline),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  height: 10,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notifier.levels.length,
                  itemBuilder: (context, index) =>
                      choiceItem(index, notifier.levels[index]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTapDown: (_) => isTapped.value = true,
            onTapUp: (_) => isTapped.value = false,
            onTap: () {
              if (selectedLevel.value == null) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        const CommonDialog(title: '硬さを選択してください'));
                return;
              }
              // 新規作成
              ref
                  .watch(toiletHomeNotiferProvider.notifier)
                  .saveToilet(selectedLevel.value!, selectedDate.value);
              ref.watch(tabIndexProvider.notifier).state = 0;
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: isTapped.value
                      ? null
                      : const [BoxShadow(offset: Offset(0, 2))],
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.amber,
                  border: Border.all(color: Colors.black, width: 2)),
              child: const Text(
                '決定',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
