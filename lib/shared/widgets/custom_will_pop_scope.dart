import 'package:flutter/material.dart';

class CustomwillPopScope extends StatelessWidget {
  final Widget child;
  const CustomwillPopScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: child, onWillPop: () async => false);
  }
}
