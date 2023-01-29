// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:golearnv2/configs/constants.dart';
import 'package:google_fonts/google_fonts.dart';

//
// BACKGROUND COLOR THEME
final appTheme = ThemeData(
  primaryColor: kBlue,
  textTheme: TextTheme(
    bodyText2: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: GoogleFonts.notoSans().fontFamily),
    headline1: TextStyle(
        color: Colors.white,
        fontSize: 58,
        fontFamily: GoogleFonts.notoSans().fontFamily,
        fontWeight: FontWeight.bold),
  ),

  //
  //APPBAR THEME
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: GoogleFonts.notoSans().fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    color: kBlue,
  ),
  scaffoldBackgroundColor: kWhite,

  //DIALOG THEME
  dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCircularBorderRadious),
      ),
      backgroundColor: kBlue,
      contentTextStyle: TextStyle(
          fontFamily: GoogleFonts.notoSans().fontFamily,
          fontSize: 20,
          color: Colors.white),
      titleTextStyle: TextStyle(
          fontFamily: GoogleFonts.notoSans().fontFamily,
          fontSize: 20,
          color: Colors.white)),

  //BUTTONS THEME
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCircularBorderRadious),
          side: BorderSide(
            color: Colors.white,
          ),
        ),
        primary: kRed,
        textStyle: TextStyle(
            fontFamily: GoogleFonts.notoSans().fontFamily,
            fontSize: 15,
            color: Colors.white)),
  ),

  //PROGRESS INIDICATOR THEME
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: kRed,
    linearTrackColor: Colors.grey,
  ),
  switchTheme:
      SwitchThemeData(thumbColor: MaterialStateProperty.all<Color>(kBlue)),

  // LIST TILE THEME
  listTileTheme: ListTileThemeData(
    textColor: Colors.white,
    iconColor: Colors.white,
  ),
);
