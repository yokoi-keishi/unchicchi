import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unchicchi/presentation/providers/common/tab_index_provider.dart';
import 'package:unchicchi/presentation/widgets/common/common_tab_item.dart';

class CommonAppbar extends HookConsumerWidget implements PreferredSizeWidget {
  const CommonAppbar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> titles = ['HOME', 'ADD', 'SUMMARY'];
    return AppBar(
      title: Text(
        titles[ref.watch(tabIndexProvider)],
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: tabNavigatorBackgroundColor[ref.watch(tabIndexProvider)],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
