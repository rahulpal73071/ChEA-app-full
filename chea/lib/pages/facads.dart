import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:chea/pages/event_pages/template.dart';
import 'package:chea/models/facad_model.dart';
import 'package:chea/widgets/facad_card.dart';

class FacAd extends StatefulWidget {
  const FacAd({super.key});

  @override
  State<FacAd> createState() => _FacAdState();
}

class _FacAdState extends State<FacAd> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic> jsonData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String jsonString = await rootBundle.loadString('assets/data/facads.json');
    final data = json.decode(jsonString);

    setState(() {
      jsonData = data;
      _tabController = TabController(length: jsonData.keys.length, vsync: this);
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: CustomTabView(
        pageTitle: 'FacAds',
        tabs: jsonData.entries.map((entry) {
          final String title = entry.key;
          final List<dynamic> facadsJson = entry.value['data'];
          final List<Facad> facads = facadsJson.map((e) => Facad.fromJson(e)).toList();

          return TabData(
            title: title,
            content: Container(
              color: Color(defaultBackground), 
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...facads.map((facad) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: SizedBox(
                            height: 500,
                            width: 400,
                            child: FacadCard(facad: facad),
                          ),
                        )),
                    const SizedBox(height: 20) 
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
