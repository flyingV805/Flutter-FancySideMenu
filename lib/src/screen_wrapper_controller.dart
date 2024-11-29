import '../fancy_side_menu.dart';

class ScreenWrapperController {

  ScreenWrapperState? _wrapperState;

  void connectState(ScreenWrapperState state){
    _wrapperState = state;
  }

  void showMenu(){
    _wrapperState?.showMenu();
  }

  void hideMenu(){
    _wrapperState?.hideMenu();
  }

}