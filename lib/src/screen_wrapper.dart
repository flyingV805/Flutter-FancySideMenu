import 'dart:math';

import 'package:fancy_side_menu/src/screen_wrapper_controller.dart';
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
  State<StatefulWidget> createState() => ScreenWrapperState();

}

class ScreenWrapperState extends State<ScreenWrapper> with SingleTickerProviderStateMixin {

  bool _isMenuOpened = false;

  late AnimationController _animController;
  late Animation<double> _translateAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    widget.controller.connectState(this);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250)
    )..addListener((){ setState(() { }); });

    _translateAnim = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.fastOutSlowIn));

    _scaleAnim = Tween<double>(begin: 1.0, end: .8)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.fastOutSlowIn));

    super.initState();
  }

  void showMenu(){
    if(_isMenuOpened){
      _animController.forward();
    }else{
      _animController.reverse();
    }
    _isMenuOpened = !_isMenuOpened;
    /*setState(() {
      _isMenuOpened = !_isMenuOpened;
    });*/
  }

  void hideMenu(){
    setState(() {
      _isMenuOpened = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          left: _translateAnim.value * -100,
          child: SafeArea(child: widget.sideMenu)
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, .001)
            ..rotateY(1 - 30 * _translateAnim.value * pi / 180),
          //offset: Offset(_translateAnim.value * 200, 0),
          child: Transform.scale(
            scale: _scaleAnim.value,
            child: widget.scaffold
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

}