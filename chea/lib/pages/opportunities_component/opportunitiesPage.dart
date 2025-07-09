import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/bottom_navbar.dart';
import '../../utils/cheagpt.dart';

int defaultBackground = 0xff08050c;

class Opportunities_Detail_Page extends StatelessWidget {
  final String title;
  final String stipend;
  final String location;
  final String role;
  final String domain;
  final String description;
  const Opportunities_Detail_Page({
    Key? key,
    required this.title,
    required this.stipend,
    required this.location,
    required this.role,
    required this.domain,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(defaultBackground),
      floatingActionButton: ChEAGPT(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: 2,
        onItemTapped: (int index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/blog');
          } else if (index == 0)
            Navigator.pushNamed(context, '/home');
          else if (index == 3) Navigator.pushNamed(context, '/profile');
        },
      ),
      appBar: AppBar(
        // leading: Image.asset(widget.icon),
        automaticallyImplyLeading: false,
        backgroundColor: Color(defaultBackground),
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            'Opportunities',
            style: GoogleFonts.nunitoSans(
                color: Colors.white, fontSize: 43, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff201f1f),
                    borderRadius: BorderRadius.circular(32)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 32.0, right: 32.0, top: 40, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.nunitoSans(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.w700)),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.white, size: 20),
                          SizedBox(
                            width: 5,
                          ),
                          Text(location,
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.monetization_on_rounded,
                              color: Colors.white, size: 20),
                          SizedBox(
                            width: 5,
                          ),
                          Text(stipend,
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                            // Default text style
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            fontStyle: FontStyle.italic,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Domain: ',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontStyle:
                                    FontStyle.italic)), // Regular text
                            TextSpan(text: domain),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                            // Default text style
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            fontStyle: FontStyle.italic,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Role: ',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontStyle:
                                    FontStyle.italic)), // Regular text
                            TextSpan(text: role),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                            // Default text style
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            fontStyle: FontStyle.italic,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Description: ',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontStyle:
                                    FontStyle.italic)), // Regular text
                            TextSpan(text: description),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient:const LinearGradient(
                                        colors:  [
                                          Color(0xffff7a00),
                                          Color(0xffd45151)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight)),
                                child: Text(
                                  'Apply Now',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
