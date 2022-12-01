import 'package:flutter/material.dart';

class homeProvider extends ChangeNotifier
{
  String url = "https://www.google.com/";
  int progressbar = 0;

  void changeUrl(String link)
  {
    url = link;
    notifyListeners();
  }

  void changeProgress(int cv)
  {
    progressbar = cv;
    notifyListeners();
  }

}