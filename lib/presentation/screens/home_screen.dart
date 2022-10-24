import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unchicchi/presentation/notifier/toilet_home_notifier.dart';
import 'package:unchicchi/presentation/providers/common/tab_index_provider.dart';
import 'package:unchicchi/presentation/widgets/common/common_container.dart';
import 'package:unchicchi/presentation/widgets/common/common_tab_item.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateFormat format = DateFormat('HH:mm');

    final state = ref.watch(toiletHomeNotiferProvider);
    final notifier = ref.watch(toiletHomeNotiferProvider.notifier);

    useMemoized(() async => await notifier.initToiletSet());

    final _selectedDay = useState(DateTime.now());
    final _focusedDay = useState(DateTime.now());

    return Container(
        color: tabNavigatorBackgroundColor[ref.watch(tabIndexProvider)],
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              CommonContainer(
                child: TableCalendar(
                  locale: 'ja',
                  rowHeight: 40,
                  focusedDay: _focusedDay.value,
                  firstDay: DateTime(DateTime.now().year - 2),
                  lastDay: DateTime(DateTime.now().year + 2),
                  currentDay: DateTime.now(),
                  eventLoader: notifier.showCalendarEvents,
                  daysOfWeekHeight: 25,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay.value, selectedDay)) {
                      _selectedDay.value = selectedDay;
                      _focusedDay.value = focusedDay;
                    }
                  },
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
                  calendarBuilders: CalendarBuilders(
                      singleMarkerBuilder: notifier.showEventMarker),
                ),
              ),
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notifier.calendarSelected(_selectedDay.value).length,
                itemBuilder: (context, index) {
                  final toilet =
                      notifier.calendarSelected(_selectedDay.value)[index];
                  return InkWell(
                    onLongPress: () => notifier.deleteToilet(toilet.id),
                    child: Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: const [BoxShadow(offset: Offset(0, 2))],
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Stack(
                          children: [
                            Center(
                                child: Text(
                              toilet.level2Text ?? '',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                format.format(toilet.date ?? DateTime.now()),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            )
                          ],
                        )),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
              )
            ]),
          ),
        ));
  }
}
