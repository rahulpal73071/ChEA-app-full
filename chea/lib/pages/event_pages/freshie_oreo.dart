import 'package:chea/pages/event_pages/template.dart';
import 'package:flutter/material.dart';

class FreshieOrientation extends StatefulWidget {
  @override
  _FreshieOrientationState createState() => _FreshieOrientationState();
}

class _FreshieOrientationState extends State<FreshieOrientation>
    with SingleTickerProviderStateMixin {
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
        // icon: 'assets/images/3.png',
        pageTitle: 'Freshie Orientation', tabs: [
        TabData(
          title: '2023',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: '2022',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: '2019',
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
        TabData(
          title: '2017',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
      ]),
    );
  }
}
