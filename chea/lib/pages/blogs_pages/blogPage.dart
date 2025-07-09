import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/bottom_navbar.dart';
import '../../utils/cheagpt.dart';
import '../blogs.dart';

class BlogPage extends StatefulWidget {
  final String imageUrl;
  final String description;
  final bool isBookmarked;
  final String title;
  final String date;

  BlogPage({
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.description,
    required this.isBookmarked,
  });

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Color(defaultBackground),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Blogs',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.white,
                                fontSize: 42,
                                fontWeight: FontWeight.w700)),
                        IconButton(
                          icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: Colors.white,
                              size: 40),
                          onPressed: () {
                            setState(() {
                              isBookmarked = !isBookmarked;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: DecorationImage(
                              image: widget.imageUrl.startsWith('http')
                                  ? NetworkImage(widget.imageUrl)
                                  : AssetImage(widget.imageUrl)
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                  Colors.black,
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.title,
                                      style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "\n ${widget.date}",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.description,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: MyNavigationBar(
          selectedIndex: 1,
          onItemTapped: (int index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/blog');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/opportunities');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/profile');
            }
          },
        ),
        floatingActionButton: ChEAGPT(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
