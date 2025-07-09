import 'package:chea/pages/event_pages/template.dart';
import 'package:flutter/material.dart';

class Miscellaneous extends StatefulWidget {
  @override
  _MiscellaneousState createState() => _MiscellaneousState();
}

class _MiscellaneousState extends State<Miscellaneous>
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
      body: CustomTabView(pageTitle: 'Miscellaneous', tabs: [
        TabData(
          title: '2023 - 2024',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: '2021 - 2022',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: '2020 - 2021',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        
      ]),
    );
  }
}
