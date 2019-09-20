import 'package:flutter/material.dart';
import 'package:kenote/src/ui/homepage.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.white,
        fontFamily: 'Chilanka'
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage()
    );
  }
}