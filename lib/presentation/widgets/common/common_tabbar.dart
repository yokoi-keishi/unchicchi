import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unchicchi/presentation/providers/common/back_button_provider.dart';
import 'package:unchicchi/presentation/providers/common/tab_index_provider.dart';
import 'package:unchicchi/presentation/widgets/common/common_tab_item.dart';

class CommonTabBar extends HookConsumerWidget {
  const CommonTabBar({Key? key}) : super(key: key);

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: tabIcon[tabItem]!,
      label: tabName[tabItem],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(tabIndexProvider);
    final tabIndexNotifier = ref.watch(tabIndexProvider.notifier);
    return SnakeNavigationBar.color(
      items: [
        _buildItem(TabItem.home),
        _buildItem(TabItem.add),
        _buildItem(TabItem.summary),
      ],
      elevation: 0,
      backgroundColor: Colors.white,
      snakeViewColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      behaviour: SnakeBarBehaviour.floating,
      padding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(width: 2.0, color: Colors.black)),
      snakeShape: SnakeShape.circle,
      currentIndex: tabIndex,
      onTap: (int selectedIndex) {
        if (tabIndexNotifier.state == selectedIndex) {
          navigatorIndexToKeys[selectedIndex]?.currentState!.pushAndRemoveUntil(
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return tabNavigatorWidget[selectedIndex] as Widget;
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  transitionDuration: const Duration(milliseconds: 250),
                ),
                (route) => false,
              );
        }
        tabIndexNotifier.state = selectedIndex;
        ref.watch(backButtonProvider.notifier).state = false; // 戻るボタン非表示
      },
    );
  }
}
