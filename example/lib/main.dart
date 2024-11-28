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
      home: Scaffold(
        appBar: AppBar(title: Text('EXAMPLE'),),
      ),
    );
  }

}