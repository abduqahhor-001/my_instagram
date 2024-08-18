import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/home_page.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';



class SplashPage extends StatefulWidget {
  static final String id = "splash_page";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTimer();
  }

  _initTimer(){
    Timer(Duration(seconds: 2),(){
        _callSignInPage();
    });

  }

  _callSignInPage(){
    Navigator.pushNamed(context,SigninPage.id );
  }

  _callHomePage(){
    Navigator.pushNamed(context,HomePage.id );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(232, 150, 94, 1.0),
              Color.fromRGBO(211, 102, 64, 1.0),
            ]
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: Center(
              child: Text("Instagram", style: TextStyle(color: Colors.white, fontSize: 50,fontFamily: "Billabong"),),
            )),
            Text("All rights reserved",style: TextStyle(color: Colors.white,fontSize: 16 ),),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )
    );
  }
}
