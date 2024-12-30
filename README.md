# Fancy Side Menu

Side menu with 3D effect for your Flutter application
<br/>
<br/>
<img src="/decor/demo.gif" width="400" />

## Getting started

TBA

## Usage

TBA

```dart
final ScreenWrapperController controller = ScreenWrapperController();
//Current route root widget
ScreenWrapper(
  backgroundColor: switch(Theme.of(context).brightness){
    Brightness.dark => const Color(0xff290033),
    Brightness.light => const Color(0xffe2a6fa),
  },
  controller: controller,
  //your main screen content
  scaffold: Scaffold(),
  //your side menu content
  sideMenu: Column()
)

```

## Roadmap

✅ Width and background as parameters

✅ 'Back' button handler

✅ GestureDetector for closing

✅ GestureDetector for dragging

## Additional information

Inspired by [This Wonderful Tutorial](https://www.youtube.com/watch?v=Z37ukFI4Ot0)
