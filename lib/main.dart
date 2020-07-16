
import 'package:covid19_tracker/route/routes.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: Routes.getRoutes(),
      initialRoute: '/',
      theme: ThemeData(
        //primarySwatch: Colors.blue[600],
        //canvasColor: Colors.indigo
      ),
      debugShowCheckedModeBanner: false,
      //home: OnbordingFlow (),
    );
  }
}
