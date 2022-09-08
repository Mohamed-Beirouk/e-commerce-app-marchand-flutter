import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



ThemeData lightTheme =  ThemeData(

scaffoldBackgroundColor: Colors.white,
appBarTheme: AppBarTheme(
backwardsCompatibility: false,
systemOverlayStyle: SystemUiOverlayStyle(
statusBarColor: Colors.white,
),
backgroundColor: Colors.white,
elevation: 0,
titleTextStyle: TextStyle(
color: Colors.black,
fontSize: 20,
fontWeight: FontWeight.bold,

),
iconTheme: IconThemeData(
color: Colors.black,
),
),
floatingActionButtonTheme: FloatingActionButtonThemeData(
backgroundColor:Colors.deepOrange,
),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
type: BottomNavigationBarType.fixed,
selectedItemColor: Colors.deepOrange,
elevation: 20
)
);

ThemeData darktheme = ThemeData(
  scaffoldBackgroundColor: Colors.black26,
);