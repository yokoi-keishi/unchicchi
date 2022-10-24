import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unchicchi/presentation/providers/common/tab_index_provider.dart';
import 'package:unchicchi/presentation/widgets/common/common_appbar.dart';
import 'package:unchicchi/presentation/widgets/common/common_tab_item.dart';
import 'package:unchicchi/presentation/widgets/common/common_tabbar.dart';

class AppScreen extends HookConsumerWidget {
  const AppScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CommonAppbar(),
      backgroundColor: tabNavigatorBackgroundColor[ref.watch(tabIndexProvider)],
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        child: Navigator(
          key: navigatorIndexToKeys[ref.watch(tabIndexProvider)],
          onGenerateRoute: (RouteSettings routeSettings) {
            return CupertinoPageRoute(
              builder: (BuildContext context) {
                return tabNavigatorWidget[ref.watch(tabIndexProvider)]
                    as Widget;
              },
            );
          },
        ),
      ),
      bottomNavigationBar:
          const Visibility(visible: true, child: CommonTabBar()),
    );
  }
}
