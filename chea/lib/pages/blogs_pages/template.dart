// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:chea/utils/bottom_navbar.dart';
import 'package:chea/utils/cheagpt.dart';
import 'package:chea/utils/side_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

int defaultBackground = 0xff05090d;

class TabData {
  final String title;
  final Widget content;

  TabData({required this.title, required this.content});
}

class CustomTabView extends StatefulWidget {
  final String pageTitle;
  // final String icon;
  final List<TabData> tabs;

  const CustomTabView({
    Key? key,
    required this.pageTitle,
    required this.tabs,
    // required this.icon,
  }) : super(key: key);

  @override
  _CustomTabViewState createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      floatingActionButton: ChEAGPT(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        // leading: Image.asset(widget.icon),
        automaticallyImplyLeading: false,
        backgroundColor: Color(defaultBackground),
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            widget.pageTitle,
            style: GoogleFonts.nunitoSans(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 20),
            child: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/Hamburger_LG.svg',
                    height: 40,
                  ));
            }),
          ),
        ],
      ),
      bottomNavigationBar: MyNavigationBar(
          selectedIndex: 1,
          onItemTapped: (int index) {
            if (index == 0) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            } else if (index == 1)
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/blog',
                (route) => false,
              );
            else if (index == 3)
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/opportunities', (route) => false,
              );
            else if (index == 4)
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/profile',
                (route) => false,
              );
          }),
      endDrawer: buildDrawer(width: MediaQuery.of(context).size.width),
      body: Container(
        color: Color(defaultBackground),
        child: Column(
          children: [
        Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
        child: SearchBar(
          hintText: 'Search...',
          padding:
          const WidgetStatePropertyAll(EdgeInsets.only(left: 20)),
          leading: (const Icon(
            Icons.search,
            color: Colors.white,
            size: 32,
          )),
          textStyle: WidgetStatePropertyAll(GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white)),
          elevation: const WidgetStatePropertyAll(0),
          backgroundColor:
          const WidgetStatePropertyAll(Color(0xff3c3838)),
        ),
            ),
            Container(
              color: Color(defaultBackground),
              child: TabBar(
                isScrollable: true,
                controller: _tabController,
                indicatorColor: const Color(0xffff752c),
                dividerColor: Color(defaultBackground),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: widget.tabs
                    .map((tab) => Tab(
                  child: Container(
                    width: 120,
                    child: Text(tab.title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                ))
                    .toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: widget.tabs.map((tab) => tab.content).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
