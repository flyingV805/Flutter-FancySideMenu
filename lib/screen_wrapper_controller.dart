import 'dart:ui';

class ScreenWrapperController {

  VoidCallback? onMenuOpened;
  VoidCallback? onMenuClosed;

  void showMenu(){
    if(onMenuOpened != null){ onMenuOpened!(); }
  }

  void hideMenu(){
    if(onMenuClosed != null){ onMenuClosed!(); }
  }

}