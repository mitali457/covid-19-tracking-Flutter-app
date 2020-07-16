
import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }
  startTime() async {
    var _duration = Duration(seconds: 3);
     Timer(_duration, 
     () => Navigator.of(context).pushReplacementNamed("/home")
            );
  }
  void navigationPage() async {
    print('Welcom to splash screen');
  }

 @override
  Widget build(BuildContext context) {
    return Center(
      
      child: Stack(
        children: [
           Container(
             
              decoration: BoxDecoration(
         
        
          
           
              //color: Colors.blue[700],
          image: DecorationImage(
            image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSeSs7N0IKonT__sP5GPfWUEsSKrWbIz63d1g&usqp=CAU"),
             fit: BoxFit.fill
             ),
        )),
        // Padding(
        //   padding: const EdgeInsets.only(top:400,left: 60),
        //   child: Text("Covid Tracker", style: TextStyle(fontSize:56,
        //   decoration: TextDecoration.none,
        //               color:Colors.black,
        //               fontWeight:FontWeight.bold),),
        // )
        ]),
    );
  }
}