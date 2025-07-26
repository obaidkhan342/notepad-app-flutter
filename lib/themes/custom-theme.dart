// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
      foregroundColor: Colors.black,
      // backgroundColor: Colors.white,
    )),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            iconColor: Colors.black, foregroundColor: Colors.black)),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,

      // unselectedItemColor: Colors.white,
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: const Color.fromARGB(58, 255, 252, 252)),
    // useMaterial3: true,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: const Color.fromARGB(255, 245, 242, 242)
    
    )
    );

//dark theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.orange,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 1,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromARGB(255, 31, 31, 31),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.orange,
    unselectedItemColor: Colors.white,
  ),
);
