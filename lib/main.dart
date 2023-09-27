// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:epikrizimweb/pages/main/randevuScreen.dart';
import 'package:epikrizimweb/pages/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(ecommerce());
}

class ecommerce extends StatelessWidget {
  const ecommerce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        //DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // Here !
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('tr')],
      locale: Locale('tr'),
      debugShowCheckedModeBanner: false,
      home: welcomeScreen(),
    );
  }
}
