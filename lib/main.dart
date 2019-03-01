import 'package:flutter/material.dart';
import 'package:trailers/ui/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  var title = "Flutter Trailers";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "$title",
      debugShowCheckedModeBanner: false,
      home: Home(
        header: "$title",
      ),

      theme: ThemeData(
//        primarySwatch: Colors.white,
        primaryColor: Colors.white,
        accentColor: Colors.blue,
      ),
    );
  }
}
