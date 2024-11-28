library fancy_side_menu;

import 'package:fancy_side_menu/screen_wrapper_controller.dart';
import 'package:flutter/material.dart';

class ScreenWrapper extends StatefulWidget {

  final ScreenWrapperController controller;
  final Scaffold scaffold;
  final Widget sideMenu;

  const ScreenWrapper({
    super.key,
    required this.controller,
    required this.scaffold,
    required this.sideMenu
  });

  @override
  State<StatefulWidget> createState() => _ScreenWrapperState();

}

class _ScreenWrapperState extends State<ScreenWrapper>{

  @override
  void initState() {
    widget.controller.onMenuOpened = (){

    };
    widget.controller.onMenuOpened = (){

    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }



}