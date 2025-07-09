import 'package:chea/pages/event_pages/template.dart';
import 'package:flutter/material.dart';

class PanelDiscussion extends StatefulWidget {
  @override
  _PanelDiscussionState createState() => _PanelDiscussionState();
}

class _PanelDiscussionState extends State<PanelDiscussion>
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
      body: CustomTabView(pageTitle: 'Panel Discussions', tabs: [
        TabData(
          title: 'PD - 4',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: 'PD - 3',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: 'PD - 2',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: 'PD - 1',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        
      ]),
    );
  }
}
