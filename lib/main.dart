import 'package:flutter/material.dart';
import 'package:in_app_web/homeScreen.dart';
import 'package:in_app_web/homeprovider.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => homeProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(context) => homeScreen(),
        },
      ),
    ),
  );
}