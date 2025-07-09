import 'package:chea/pages/event_pages/template.dart';
import 'package:flutter/material.dart';

class Convocation extends StatefulWidget {
  @override
  _ConvocationState createState() => _ConvocationState();
}

class _ConvocationState extends State<Convocation>
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
      body: CustomTabView(pageTitle: 'Convocation', tabs: [
        TabData(
          title: '2022',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: '2021',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
        TabData(
          title: '2020',
          content: Container(
            color: Color(defaultBackground),
          ),
        ),
      ]),
    );
  }
}
