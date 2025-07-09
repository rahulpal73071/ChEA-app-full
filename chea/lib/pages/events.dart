import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chea/models/event_model.dart';
import 'package:chea/utils/bottom_navbar.dart';
import 'package:chea/utils/cheagpt.dart';
import 'package:chea/utils/side_navbar.dart';
import 'package:chea/widgets/event_card.dart';

int defaultBackground = 0xff09050d;

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> with TickerProviderStateMixin {
  late TabController _tabController;
  Map<String, List<Event>> yearWiseEvents = {};
  List<String> years = [];

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    final String data =
        await rootBundle.loadString('assets/data/event_data.json');
    final Map<String, dynamic> jsonResult = json.decode(data);

    final Map<String, List<Event>> loaded = {};
    final List<String> sortedYears = List<String>.from(jsonResult.keys)
      ..sort((a, b) {
        if (a == 'Pre-2024') return 1;
        if (b == 'Pre-2024') return -1;
        return b.compareTo(a);
      });

    for (final year in sortedYears) {
      final List<dynamic> eventsJson = jsonResult[year];
      loaded[year] = eventsJson.map((e) => Event.fromJson(e)).toList();
    }

    if (!mounted) return;

    setState(() {
      yearWiseEvents = loaded;
      years = sortedYears;
      _tabController = TabController(length: years.length, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(defaultBackground),
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: Color(defaultBackground),
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20),
          child: Text(
            'Events',
            style: GoogleFonts.nunitoSans(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 20),
            child: Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: const Icon(Icons.menu, color: Colors.white, size: 36),
              ),
            ),
          ),
        ],
        bottom: years.isEmpty
            ? null
            : TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.orange,
                labelColor: Colors.white,
                tabs: years.map((y) => Tab(text: y)).toList(),
              ),
      ),
      body: years.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: years.map((year) {
                final events = yearWiseEvents[year]!;
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: events
                      .map((event) => EventCardWidget(event: event))
                      .toList(),
                );
              }).toList(),
            ),
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: 5,
        onItemTapped: (index) {
          if (index == 0) Navigator.pushNamed(context, '/home');
          if (index == 1) Navigator.pushNamed(context, '/blog');
          if (index == 3) Navigator.pushNamed(context, '/opportunities');
          if (index == 4) Navigator.pushNamed(context, '/profile');
        },
      ),
      floatingActionButton: ChEAGPT(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      endDrawer: buildDrawer(width: MediaQuery.of(context).size.width),
    );
  }
}
