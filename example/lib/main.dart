import 'package:fancy_side_menu/fancy_side_menu.dart';
import 'package:flutter/material.dart';

void main(){
  final ScreenWrapperController controller = ScreenWrapperController();
  runApp(MyApp(controller: controller));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key, required this.controller});

  final ScreenWrapperController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light
          ),
          useMaterial3: true,
          brightness: Brightness.light
      ),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark
          ),
          useMaterial3: true,
          brightness: Brightness.dark
      ),
      home: ScreenWrapper(
        controller: controller,
        scaffold: Scaffold(
          appBar: AppBar(title: Text('EXAMPLE'),),
          body: TextButton(
            onPressed: (){
              controller.showMenu();
            },
            child: Text('CHECK')
          ),
        ), 
        sideMenu: Container(
          color: Colors.blue,
          child: const Column(
            children: [
              Text('sdfsdfsdfsdf')
            ],
          ),
        )
      ),
    );
  }

}