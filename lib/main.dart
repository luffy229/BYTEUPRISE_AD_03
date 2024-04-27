import 'package:flutter/material.dart';
import 'main_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 25, 72, 101),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        elevation: 0,
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: OrientationBuilder(
            builder: (context, orientation) {
              return MainDisplay(
                isLandscape: orientation == Orientation.landscape,
              );
            },
          ),
        ),
      ),
    );
  }
}
