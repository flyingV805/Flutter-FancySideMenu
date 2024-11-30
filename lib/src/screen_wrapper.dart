import 'dart:math';

import 'package:fancy_side_menu/src/screen_wrapper_controller.dart';
import 'package:flutter/material.dart';

class ScreenWrapper extends StatefulWidget {

  final ScreenWrapperController controller;
  final Scaffold scaffold;
  final Widget sideMenu;
  final double menuWidth;
  final Color? backgroundColor;

  const ScreenWrapper({
    super.key,
    required this.controller,
    required this.scaffold,
    required this.sideMenu,
    this.menuWidth = 264.0,
    this.backgroundColor
  });

  @override
  State<StatefulWidget> createState() => ScreenWrapperState();

}

class ScreenWrapperState extends State<ScreenWrapper> with SingleTickerProviderStateMixin {

  bool _isMenuOpened = false;

  late AnimationController _animController;
  late Animation<double> _translateAnim;
  late Animation<double> _scaleAnim;
  late Animation<double> _pivotAnim;

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

    _pivotAnim = Tween<double>(begin: 0, end: .5)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.fastOutSlowIn));

    super.initState();
  }

  void showMenu(){
    _isMenuOpened = !_isMenuOpened;
    if(_isMenuOpened){
      _animController.forward();
    }else{
      _animController.reverse();
    }
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
        const Positioned.fill(
          child: ColoredBox(color: Colors.deepPurple/*Theme.of(context).cardColor*/ )
        ),
        Positioned(
          height: MediaQuery.of(context).size.height,
          width: widget.menuWidth,
          //duration: const Duration(milliseconds: 20),
          left: (1 - _translateAnim.value) * -(widget.menuWidth),
          child: Material(
            color: Colors.deepPurple,
            child: SafeArea(
              child: widget.sideMenu
            )
          )
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, .001)
            ..rotateY(_pivotAnim.value),
          //offset: Offset(_translateAnim.value * 200, 0),
          child: Transform.translate(
            offset: Offset(
              _translateAnim.value * widget.menuWidth,
              0
            ),
            child: Transform.scale(
              scale: _scaleAnim.value,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_translateAnim.value * 24),
                child: widget.scaffold
              )
            ),
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