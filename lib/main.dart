import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:sexta_integrada/login.dart';
import 'package:sexta_integrada/database/home_page.dart';
import 'package:sexta_integrada/sqlite/home_page.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent
    ));


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sexta',
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context ) => AuthThreePage(),
        'database' : (BuildContext context ) => HomePageDatabase(),
        'sqlite' : (BuildContext context ) => HomePageSqlite(),
      },
    );
  }

}