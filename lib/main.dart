// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'package:firebase_database/firebase_database.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
  return GetMaterialApp(
    theme: ThemeData(
      primaryColor: Colors.deepOrange,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange
      ),
      appBarTheme: AppBarTheme(
        color: Colors.deepOrange,
      )
    ),
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  );
  }

}