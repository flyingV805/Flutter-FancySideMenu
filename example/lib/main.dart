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
        backgroundColor: switch(Theme.of(context).brightness){
          Brightness.dark => const Color(0xff290033),
          Brightness.light => const Color(0xffe2a6fa),
        },
        controller: controller,
        scaffold: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){ controller.showMenu(); },
              icon: const Icon(Icons.menu)
            ),
            title: const Text('EXAMPLE'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 64),
                const Text("⤣", style: TextStyle(fontSize: 48)),
                const Wrap(
                  children: [
                    Text('Click on '),
                    SizedBox(width: 8),
                    Icon(Icons.menu),
                    SizedBox(width: 8),
                    Text('in AppBar to show the menu'),
                  ],
                ),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: (){ debugPrint('POINTER NOT ABSORBED'); },
                  child: const Text('ABSORB POINTER TEST')
                )
              ],
            ),
          ),
        ), 
        sideMenu: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.transparent),
              currentAccountPicture: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),),
              accountName: Text('Vlad Petrov', style: Theme.of(context).textTheme.titleMedium),
              accountEmail: Text('petrov.vladislav1992@gmail.com', style: Theme.of(context).textTheme.bodyMedium)
            ),
            ListTile(
              leading: const Icon(Icons.access_time_filled),
              title: Text('Some Time', style: Theme.of(context).textTheme.titleMedium,),
              onTap: (){ debugPrint('Menu item tap');},
            ),
            ListTile(
              leading: const Icon(Icons.access_time_filled),
              title: const Text('Some Time'),
              onTap: (){},
            ),
            ListTile(
              leading: const Icon(Icons.access_time_filled),
              title: const Text('Some Time'),
              onTap: (){},
            ),
            ListTile(
              leading: const Icon(Icons.access_time_filled),
              title: const Text('Some Time'),
              onTap: (){},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.access_time_filled),
              title: const Text('Leave'),
              onTap: (){},
            )
          ],
        )
      ),
    );
  }

}