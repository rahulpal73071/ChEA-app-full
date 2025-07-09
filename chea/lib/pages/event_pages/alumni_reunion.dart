import 'package:chea/pages/event_pages/template.dart';
import 'package:flutter/material.dart';

class AlumniReunion extends StatefulWidget {
  @override
  _AlumniReunionState createState() => _AlumniReunionState();
}

class _AlumniReunionState extends State<AlumniReunion>
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
      body: CustomTabView(pageTitle: 'Alumni Reunion', tabs: [
        TabData(
          title: '2022 - 2023',
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
        
      ]),
    );
  }
}
