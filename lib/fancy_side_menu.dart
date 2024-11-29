library fancy_side_menu;

import 'package:flutter/material.dart';

class ScreenWrapperController extends InheritedWidget {

  final ScreenWrapperState state;

  const ScreenWrapperController({super.key, required this.state, required super.child});

  static ScreenWrapperState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ScreenWrapperController>() as ScreenWrapperController).state;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return this != oldWidget;
  }

}

class ScreenWrapper extends StatefulWidget {

  final Scaffold scaffold;
  final Widget sideMenu;

  const ScreenWrapper({
    super.key,
    required this.scaffold,
    required this.sideMenu
  });

  @override
  State<StatefulWidget> createState() => ScreenWrapperState();

}

class ScreenWrapperState extends State<ScreenWrapper>{

  bool _isMenuOpened = false;

  @override
  void initState() {

    super.initState();
  }

  void showMenu(){
    setState(() {
      _isMenuOpened = true;
    });
  }

  void hideMenu(){
    setState(() {
      _isMenuOpened = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapperController(
      state: this,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: _isMenuOpened ? 0 : -288,
            child: SafeArea(child: widget.sideMenu)
          ),
          Transform.translate(
            offset: const Offset(100, 0),
            child: widget.scaffold,
          )
        ],
      ),
    );
  }



}