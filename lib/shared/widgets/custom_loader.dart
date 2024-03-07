import 'package:flutter/material.dart';

class CustomOverlayLoader extends StatefulWidget {
  final List<Widget> children;
  const CustomOverlayLoader({super.key, required this.children});

  @override
  State<CustomOverlayLoader> createState() => _CustomOverlayLoaderState();
}

class _CustomOverlayLoaderState extends State<CustomOverlayLoader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.children,
    );
  }
}
