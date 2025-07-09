import 'package:chea/utils/side_navbar.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final AppBar appBar;
  final Widget body;
  final double width;

  // ignore: use_key_in_widget_constructors
  const CustomScaffold({
    required this.appBar,
    required this.body,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      endDrawer: buildDrawer(width: width),
    );
  }
}
