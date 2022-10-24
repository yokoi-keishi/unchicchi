import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unchicchi/presentation/screens/add_screen.dart';
import 'package:unchicchi/presentation/screens/home_screen.dart';
import 'package:unchicchi/presentation/screens/summary_screen.dart';

enum TabItem {
  home,
  add,
  summary,
}

const Map<TabItem, String> tabName = {
  TabItem.home: 'HOME',
  TabItem.add: 'ADD',
  TabItem.summary: 'SUMMARY',
};

Map<TabItem, Widget> tabIcon = {
  TabItem.home: const FaIcon(FontAwesomeIcons.calendarMinus),
  TabItem.add: const FaIcon(FontAwesomeIcons.plus),
  TabItem.summary: const FaIcon(FontAwesomeIcons.chartLine),
};

final navigatorIndexToKeys = {
  0: GlobalKey<NavigatorState>(),
  1: GlobalKey<NavigatorState>(),
  2: GlobalKey<NavigatorState>(),
};

final tabNavigatorWidget = {
  0: const HomeScreen(),
  1: AddScreen(),
  2: const SummaryScreen(),
};

final tabNavigatorBackgroundColor = {
  0: Colors.amber.shade100,
  1: Colors.purple.shade100,
  2: Colors.green.shade100,
};
