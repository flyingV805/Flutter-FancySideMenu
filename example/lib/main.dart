import 'package:fancy_side_menu/fancy_side_menu.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

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
        scaffold: Scaffold(
          appBar: AppBar(title: Text('EXAMPLE'),),
          body: TextButton(
            onPressed: (){
              ScreenWrapperController.of(context).showMenu();
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