import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app_ui/res/assets.dart';
import 'package:music_app_ui/util/utils.dart';

enum Tabs { home, search, playlist, saved }

extension TabExt on Tabs {
  String get name {
    switch (this) {
      case Tabs.home:
        return "Home";
      case Tabs.search:
        return "Search";
      case Tabs.playlist:
        return "Playlist";
      case Tabs.saved:
        return "Saved";
      default:
        return "";
    }
  }

  String get selectedIcon {
    switch (this) {
      case Tabs.home:
        return Assets.HOME_SELECTED_TAB;
      case Tabs.search:
        return Assets.SEARCH_SELECTED_TAB;
      case Tabs.playlist:
        return Assets.MUSIC_SELECTED_TAB;
      case Tabs.saved:
        return Assets.BOOKMARK_SELECTED_TAB;
      default:
        return "";
    }
  }

  String get unSelectedIcon {
    switch (this) {
      case Tabs.home:
        return Assets.HOME_UNSELECTED_TAB;
      case Tabs.search:
        return Assets.SEARCH_UNSELECTED_TAB;
      case Tabs.playlist:
        return Assets.MUSIC_UNSELECTED_TAB;
      case Tabs.saved:
        return Assets.BOOKMARK_UNSELECTED_TAB;
      default:
        return "";
    }
  }
}

class BottomNav extends StatefulWidget {
  final Tabs currentTab;
  final ValueChanged<Tabs> didSelectTab;
  const BottomNav(
      {Key? key, required this.currentTab, required this.didSelectTab})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ButtomNavState();
  }
}

class _ButtomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    Utils.navBarState = setState;
    return Container(
      color: Colors.black,
      height: Platform.isIOS ? 85.h : 70.h,
      child: BottomNavigationBar(
          elevation: 0,
          unselectedLabelStyle: const TextStyle(
              fontSize: (1 - 5), fontWeight: FontWeight.w600, height: 1),
          selectedLabelStyle: const TextStyle(
              fontSize: (11 - 5), fontWeight: FontWeight.w600, height: 1),
          backgroundColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            widget.didSelectTab(Tabs.values.toList()[index]);
          },
          items: Tabs.values.map((tab) => _buildItem(tab, context)).toList()),
    );
  }

  BottomNavigationBarItem _buildItem(Tabs tab, BuildContext context) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
          widget.currentTab == tab ? tab.selectedIcon : tab.unSelectedIcon,
          color: widget.currentTab == tab ? Utils.color : null,
          colorBlendMode: BlendMode.srcATop),
      label: tab.name,
    );
  }
}
