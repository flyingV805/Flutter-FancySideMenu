import 'package:fancy_side_menu/src/screen_wrapper_controller.dart';
import 'package:flutter/material.dart';

class ScreenWrapper extends StatefulWidget {

  final ScreenWrapperController controller;
  final Scaffold scaffold;
  final Widget sideMenu;
  final double menuWidth;
  final Color backgroundColor;

  const ScreenWrapper({
    super.key,
    required this.controller,
    required this.scaffold,
    required this.sideMenu,
    this.menuWidth = 264.0,
    this.backgroundColor = Colors.deepPurple
  });

  @override
  State<StatefulWidget> createState() => ScreenWrapperState();

}

class ScreenWrapperState extends State<ScreenWrapper> with SingleTickerProviderStateMixin implements PopEntry{

  bool _isMenuOpened = false;

  late AnimationController _animController;
  late Animation<double> _translateAnim;
  late Animation<double> _scaleAnim;
  late Animation<double> _pivotAnim;

  double _dragUpdatePoint = 0;

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

    canPopNotifier = ValueNotifier<bool>(_isMenuOpened);

    super.initState();
  }

  void showMenu(){
    ModalRoute.of(context)?.registerPopEntry(this);
    _animController.forward();
    setState(() { _isMenuOpened = true; });
    /*setState(() {
      _isMenuOpened = !_isMenuOpened;
    });*/
  }

  void hideMenu(){
    ModalRoute.of(context)?.unregisterPopEntry(this);
    _animController.reverse();
    setState(() {
      _isMenuOpened = false;
    });
  }

  void menuAction(){
    _animController.forward();
    setState(() {
      _isMenuOpened = false;
    });
  }

  /*bool _handleBackLogic(){
    if (_isMenuOpened){
      hideMenu();
      return true;
    }
    return false;
  }*/

  void _handleDragStart(DragStartDetails info){
    if(!_isMenuOpened){return;}
    _dragUpdatePoint = info.globalPosition.dx;
    debugPrint('DRAG START: $info');
  }

  void _handleDragUpdate(DragUpdateDetails info){
    if(!_isMenuOpened){return;}
    _dragUpdatePoint += info.delta.dx;
    final dragPosition = (_dragUpdatePoint / widget.menuWidth).clamp(0.0, 1.0);
    _animController.value = dragPosition;
  }

  void _handleDragEnd(DragEndDetails info){
    if(!_isMenuOpened){return;}
    final dragPosition = (_dragUpdatePoint / widget.menuWidth).clamp(0.0, 1.0);
    if(dragPosition >= 0.5){
      _animController.forward(from: dragPosition);
      setState(() { _isMenuOpened = true; });
    }else{
      _animController.reverse(from: dragPosition);
      setState(() { _isMenuOpened = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _isMenuOpened ?(details){
        final xPosition = details.globalPosition.dx;
        if(xPosition >= widget.menuWidth) { hideMenu(); }
      } : null,
      onHorizontalDragStart: _isMenuOpened ? _handleDragStart : null,
      onHorizontalDragEnd: _isMenuOpened ? _handleDragEnd : null,
      onHorizontalDragUpdate: _isMenuOpened ?  _handleDragUpdate : null,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ColoredBox(color: widget.backgroundColor/*Theme.of(context).cardColor*/ )
          ),
          Positioned(
            height: MediaQuery.of(context).size.height,
            width: widget.menuWidth,
            //duration: const Duration(milliseconds: 20),
            left: (1 - _translateAnim.value) * -(widget.menuWidth),
            child: Material(
              color: widget.backgroundColor,
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
            child: Transform.translate(
              offset: Offset(
                _translateAnim.value * widget.menuWidth,
                0
              ),
              child: Transform.scale(
                scale: _scaleAnim.value,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_translateAnim.value * 24),
                  child: AbsorbPointer(
                    absorbing: _isMenuOpened,
                    child: widget.scaffold
                  )
                )
              ),
            ),
            ),
        ],
        ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  late final ValueNotifier<bool> canPopNotifier;

  @override
  void onPopInvoked(bool didPop) {
    if(_isMenuOpened){hideMenu();}
    debugPrint('onPopInvoked $didPop');
  }

  @override
  void onPopInvokedWithResult(bool didPop, result) {
    if(_isMenuOpened){
      hideMenu();
      ModalRoute.of(context)?.unregisterPopEntry(this);
      return;
    }
    //debugPrint('onPopInvokedWithResult $didPop');
  }

}