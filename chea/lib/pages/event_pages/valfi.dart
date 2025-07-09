import 'package:chea/pages/event_pages/template.dart';
import 'package:flutter/material.dart';

class Valfi extends StatefulWidget {
  @override
  _ValfiState createState() => _ValfiState();
}

class _ValfiState extends State<Valfi> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabView(
        // icon: 'assets/images/2.png',
        pageTitle: 'Valfi', tabs: [
        TabData(
          title: '2023',
          content: Container(
            color: Colors.blue,
          ),
        ),
        TabData(
          title: '2022',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: '2018',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
      ]),
    );
  }
}
