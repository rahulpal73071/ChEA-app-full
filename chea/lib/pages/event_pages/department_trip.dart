import 'package:chea/pages/event_pages/template.dart';
import 'package:flutter/material.dart';

class DepartmentTrip extends StatefulWidget {
  @override
  _DepartmentTripState createState() => _DepartmentTripState();
}

class _DepartmentTripState extends State<DepartmentTrip>
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
          // icon: 'assets/images/7.png',
          pageTitle: 'Department Trips',
          tabs: [
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
              title: '2021 - 2022',
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
