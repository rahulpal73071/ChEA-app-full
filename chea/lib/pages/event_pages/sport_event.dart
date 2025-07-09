import 'package:chea/pages/event_pages/template.dart';
import 'package:flutter/material.dart';

class SportEvent extends StatefulWidget {
  @override
  _SportEventState createState() => _SportEventState();
}

class _SportEventState extends State<SportEvent>
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
      body: CustomTabView(pageTitle: 'Sport Events', tabs: [
        TabData(
          title: '2023 - 2024',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: '2022 - 2023',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: '2018 - 2019',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: '2017 - 2018',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        
      ]),
    );
  }
}
