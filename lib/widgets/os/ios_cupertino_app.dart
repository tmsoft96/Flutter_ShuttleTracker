import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/utils/bouncing_scroll_behavior.dart';

class IOSCupertinoApp extends StatefulWidget {
  final ThemeData theme;

  final List<Widget> pageOptions;

  IOSCupertinoApp({this.theme, this.pageOptions});

  @override
  _IOSCupertinoAppState createState() => _IOSCupertinoAppState();
}

class _IOSCupertinoAppState extends State<IOSCupertinoApp> {
  int _selectedTab = 0;
  final _items = [
    BottomNavigationBarItem(
      icon: Icon(IconData(0xf398,
          fontFamily: 'CupertinoIcons',
          fontPackage: 'cupertino_icons',
          matchTextDirection: true)),
      title: Text('Map'),
    ),
    BottomNavigationBarItem(
      icon: Icon(IconData(0xf394,
          fontFamily: 'CupertinoIcons',
          fontPackage: 'cupertino_icons',
          matchTextDirection: true)),
      title: Text('Schedules'),
    ),
    BottomNavigationBarItem(
      icon: Icon(IconData(0xf43d,
          fontFamily: 'CupertinoIcons',
          fontPackage: 'cupertino_icons',
          matchTextDirection: true)),
      title: Text('Settings'),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.theme,
      child: CupertinoApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 370,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint(breakpoint: 450, name: MOBILE),
            ResponsiveBreakpoint(
                breakpoint: 800, name: TABLET, autoScale: true),
            ResponsiveBreakpoint(
                breakpoint: 1000, name: TABLET, autoScale: true),
            ResponsiveBreakpoint(breakpoint: 1200, name: DESKTOP),
            ResponsiveBreakpoint(breakpoint: 2460, name: "4K", autoScale: true),
          ],
        ),
        home: SafeArea(
          top: false,
          bottom: false,
          child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              activeColor: Colors.red,
              backgroundColor: widget.theme.appBarTheme.color,
              items: _items,
              currentIndex: _selectedTab,
              onTap: (index) {
                setState(() {
                  _selectedTab = index;
                });
              },
            ),
            tabBuilder: (context, i) {
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                      navigationBar: CupertinoNavigationBar(
                        padding: EdgeInsetsDirectional.only(bottom: 10),
                        backgroundColor: widget.theme.appBarTheme.color,
                        middle: Image.asset(
                          'assets/img/logo.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      child: widget.pageOptions[i]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}