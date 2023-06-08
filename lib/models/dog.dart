import 'package:flutter/material.dart';

class Dog with ChangeNotifier {
  final String name;
  final String bread;
  int age;
  Dog({
    required this.name,
    required this.bread,
    required this.age,
  });

  void grow() {
    age++;
    notifyListeners();
  }
}
