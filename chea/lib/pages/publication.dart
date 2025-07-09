import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/publication_card.dart';
import '../../models/publication.dart';
import './event_pages/template.dart'; // For CustomTabView

class PublicationPage extends StatefulWidget {
  const PublicationPage({super.key});

  @override
  State<PublicationPage> createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  Map<String, dynamic> publicationData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final String jsonString = await rootBundle.loadString('assets/data/publications.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    setState(() {
      publicationData = jsonMap;
      isLoading = false;
    });
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
        pageTitle: 'Publications',
        tabs: publicationData.entries.map((entry) {
          final year = entry.key;
          final yearInfo = entry.value;
          // final String title = yearInfo['title'];
          // final String formula = yearInfo['formula'];
          final Color bgColor = Color(int.parse(yearInfo['bgColor']));
          final List<dynamic> data = yearInfo['data'];

          return TabData(
            title: year,
            content: Container(
              color: bgColor,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  
                  
                  const SizedBox(height: 5),
                  ...data.map((item) {
                    final pub = Publication.fromJson(item);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: PublicationCard(publication: pub),
                    );
                  })
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
