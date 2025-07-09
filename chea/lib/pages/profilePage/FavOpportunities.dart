import 'package:chea/utils/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/bottom_navbar.dart';
import '../../utils/cheagpt.dart';
import '../opportunities.dart';
import '../opportunities_component/opportunitiesCard.dart';
import '../opportunities_component/opportunitiesPage.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

int defaultBackground = 0xff09050d;

Future<List<Opportunity>> getFavorite() async {
  final token = await AuthService().getToken();
  final response = await http.get(
    Uri.parse('http://172.28.102.117:8000/opportunities/get_favorite/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'Token $token',
    },
  );
  if(response.statusCode == 200){
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((opportunity) => Opportunity.fromJson(opportunity)).toList();
  } else {
    throw Exception('Failed to load opportunities');
  }
}

class Favopportunities extends StatefulWidget {
  const Favopportunities({super.key});

  @override
  State<Favopportunities> createState() => _FavopportunitiesState();
}

class _FavopportunitiesState extends State<Favopportunities> {
  List<Opportunity> favOpportunities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getFavorite().then((value) {
      setState(() {
        favOpportunities = value;
        _isLoading = false;
      });
    });
  }

  Widget _buildOpportunitiesList(List<Opportunity> opportunities) {
    return Expanded(
      child: ListView.builder(
          itemCount: opportunities.length,
          itemBuilder: (context, index) {
            final opportunity = opportunities[index];
            return OpportunitiesCard(
              opportunity: opportunity,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Opportunities_Detail_Page(
                      title: opportunity.title,
                      stipend: opportunity.stipend,
                      location: opportunity.location,
                      domain: opportunity.domain,
                      role: opportunity.role,
                      description: opportunity.description,
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(defaultBackground),
        floatingActionButton: ChEAGPT(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: MyNavigationBar(
          selectedIndex: 3,
          onItemTapped: (int index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/blog');
            } else if (index == 0)
              Navigator.pushNamed(context, '/home');
            else if (index == 3) Navigator.pushNamed(context, '/profile');
            else if (index == 2) Navigator.pushNamed(context, '/opportunities');
          },
        ),
        body: Container(
          color: const Color(0xff09050d),
          child: Column(
              children:[
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color(0xff201f1f),
                        ),

                        child: const Icon(Icons.favorite, color: Color(0xffd45151),size:30),

                      ),
                      const SizedBox(width: 20),
                      Flexible(child: Text('Favourite Opportunities',
                          style: GoogleFonts.montserrat(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          )),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SearchBar(
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 20)),
                      hintText: 'Search...',
                      elevation: const WidgetStatePropertyAll(0),
                      hintStyle: WidgetStatePropertyAll(GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic)),
                      backgroundColor:
                      const WidgetStatePropertyAll(Color(0xff3c3838)),
                      leading: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _isLoading ? const CircularProgressIndicator(): _buildOpportunitiesList(favOpportunities)
              ]
          ),
        )
    );
  }
}