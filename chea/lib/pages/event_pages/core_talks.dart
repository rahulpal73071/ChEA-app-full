import 'package:chea/pages/event_pages/template.dart';
import 'package:flutter/material.dart';

class CoreTalk extends StatefulWidget {
  @override
  _CoreTalkState createState() => _CoreTalkState();
}

class _CoreTalkState extends State<CoreTalk>
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
        // icon:'assets/images/6.png',
        pageTitle: 'Core Talks', tabs: [
        TabData(
          title: '2020 - 2021',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: '2019 - 2020',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
      ]),
    );
  }
}
