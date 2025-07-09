import 'package:chea/pages/event_pages/template.dart';
import 'package:flutter/material.dart';

class knowYourProf extends StatefulWidget {
  @override
  _knowYourProfState createState() => _knowYourProfState();
}

class _knowYourProfState extends State<knowYourProf>
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
          // icon: 'assets/images/4.png',
          pageTitle: 'Know Your Profs',
          tabs: [
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
