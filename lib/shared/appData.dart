import 'package:flutter/material.dart';

class Appdata with ChangeNotifier{
 int _userId=0;

  int get userId => _userId;

  set userId(int value) {
    _userId = value;
  }
  User user=User();
}

class User{
  int userId=0;
}