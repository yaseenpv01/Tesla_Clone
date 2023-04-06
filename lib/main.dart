import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesla_clone/Pages/home.dart';
import 'package:tesla_clone/Utils/provider_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> HomeProvider())
      ],
      child: MaterialApp(
        title: 'Tesla',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: HomePage(),
      ),
    );
  }
}

