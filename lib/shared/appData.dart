import 'package:flutter/material.dart';

class AppData with ChangeNotifier {
  int _idx = 0;

  int get idx => _idx;

  set idx(int value) {
    _idx = value;
    notifyListeners();
  }

  User user = User();
}

class User {
  int idx = 0;
}
